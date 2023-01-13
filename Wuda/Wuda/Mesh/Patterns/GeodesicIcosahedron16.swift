//
//  GeodesicIcosahedron16.swift
//  Wuda
//
//  Found on an online source:
//  http://dmccooey.com/polyhedra/GeodesicIcosahedron16.html
//  A thank you to the author
//
// Geodesic Icosahedron Pattern 16 [5,2]

import Foundation
import SceneKit

class GeodesicIcosahedron16 {
    
    let C0  = 0.02793331013872616754305125101251
    let C1  = 0.0423443632321508843023753934720
    let C2  = 0.04842592953731604358186550756054
    let C3  = 0.0485776985387186833250135152914
    let C4  = 0.0488129069260823540917676898077
    let C5  = 0.07961326541550282902184488259847
    let C6  = 0.0917750231241588877734333459963
    let C7  = 0.093777698740970087303568745986496
    let C8  = 0.0964995932838120297773400646776
    let C9  = 0.108103221561956304553767902898
    let C10 = 0.117327525867673839075560420904
    let C11 = 0.121325305728237284339665538842
    let C12 = 0.145358857022290405003130322362
    let C13 = 0.145814418098475888760996331206
    let C14 = 0.147495561437677885021082876467
    let C15 = 0.167818569599132931381946664600
    let C16 = 0.193784786559606448584995829922
    let C17 = 0.194392116637194572086009846497
    let C18 = 0.220591992521808984824761137262
    let C19 = 0.220695112324638792234942582132
    let C20 = 0.228108372148699470386201255603
    let C21 = 0.237227955542476829758152275881
    let C22 = 0.238168675121665919475637843253
    let C23 = 0.259838725511594127064604645110
    let C24 = 0.268692385521575884766074427810
    let C25 = 0.277312076130846738415684164270
    let C26 = 0.281564285842483421006704600228
    let C27 = 0.2833657203444168989516089264351
    let C28 = 0.2990499122528236201276418662651
    let C29 = 0.326650190730243619973342424034
    let C30 = 0.331005654283446917061721021867
    let C31 = 0.334668268405477949252977907931
    let C32 = 0.358675616134773891165841471163
    let C33 = 0.373339308966642308780137946224
    let C34 = 0.379865313628228928728948991113
    let C35 = 0.403540315408511544923487567912
    let C36 = 0.403751254132254731321742673073
    let C37 = 0.405518122429557426997452334827
    let C38 = 0.41329832154111312291335364085498
    let C39 = 0.4173505676532627878425105245452
    let C40 = 0.4305620566251379348462734730246
    let C41 = 0.435446992820426211308286111400
    let C42 = 0.445884678640662429225862961384
    let C43 = 0.465928266191981471167524039837
    let C44 = 0.4823516214631476607840440180852
    let C45 = 0.502156278364292405831465737490
    let C46 = 0.505920341064052714524226703691
    let C47 = 0.507468834087908699021310201812
    let C48 = 0.5248656211367488292631531067546
    let C49 = 0.526711243526092684377987450988
    let C50 = 0.534245483480725827050914678517
    let C51 = 0.550876979451847832000582657189
    let C52 = 0.5694379433748620651537265269754
    let C53 = 0.580349337841874341317417368461
    let C54 = 0.586069201418801628483611546824
    let C55 = 0.58670167845888687708664635914502
    let C56 = 0.593380240078340314246945837851
    let C57 = 0.629231779380032659893281941322
    let C58 = 0.642193147004422668338713527659
    let C59 = 0.643681620660970637027194983807
    let C60 = 0.650651385097489047195822110494
    let C61 = 0.657655845013690537035063445902
    let C62 = 0.670642564048328418231558923651
    let C63 = 0.683688956659928467293244477497
    let C64 = 0.701860950725103271107320048309
    let C65 = 0.710493085879620129935932762732
    let C66 = 0.719068493585644461813424431212
    let C67 = 0.730264650512991876217666993093
    let C68 = 0.731883619517277517244607878030
    let C69 = 0.732892660642075735322727386164
    let C70 = 0.7652303250306158840992513809551
    let C71 = 0.765759066575646841588831348800
    let C72 = 0.770269472029498426819849023837
    let C73 = 0.793163635169342051642302631968
    let C74 = 0.800437507599502472765371479399
    let C75 = 0.804270784620590217239501508718
    let C76 = 0.824667683766234623096160732160
    let C77 = 0.824870353580552796562284202398
    let C78 = 0.842781870831653357067746872871
    let C79 = 0.849926891704671452128224523454
    let C80 = 0.852236694281940976173388778259
    let C81 = 0.852803663719278964105335453410
    let C82 = 0.869679520324236202489266712909
    let C83 = 0.891594777757735711159514562679
    let C84 = 0.899702189116410448626554542630
    let C85 = 0.904280949181737452118005614759
    let C86 = 0.912374006182546521793269411617
    let C87 = 0.917765033467176311840931900303
    let C88 = 0.939024953976648232483258839624
    let C89 = 0.939763605910283254048367013344
    let C90 = 0.961001032790775205708928641767
    let C91 = 0.969692476301152038359200789916
    let C92 = 0.970331811391214257000537407841
    let C93 = 0.989820455551056359805354219897

    public func generateVertices() -> [SCNVector3] {
        return [SCNVector3( C8, -C0, 1.0), SCNVector3( C8, C0, -1.0), SCNVector3( -C8, C0, 1.0), SCNVector3( -C8, -C0, -1.0), SCNVector3( 1.0, -C8, C0), SCNVector3( 1.0, C8, -C0), SCNVector3(-1.0, C8, C0), SCNVector3(-1.0, -C8, -C0), SCNVector3( C0, -1.0, C8), SCNVector3( C0, 1.0, -C8), SCNVector3( -C0, 1.0, C8), SCNVector3( -C0, -1.0, -C8), SCNVector3( C3, C15, C93), SCNVector3( C3, -C15, -C93), SCNVector3( -C3, -C15, C93), SCNVector3( -C3, C15, -C93), SCNVector3( C93, C3, C15), SCNVector3( C93, -C3, -C15), SCNVector3(-C93, -C3, C15), SCNVector3(-C93, C3, -C15), SCNVector3( C15, C93, C3), SCNVector3( C15, -C93, -C3), SCNVector3(-C15, -C93, C3), SCNVector3(-C15, C93, -C3), SCNVector3( C21, C9, C92), SCNVector3( C21, -C9, -C92), SCNVector3(-C21, -C9, C92), SCNVector3(-C21, C9, -C92), SCNVector3( C92, C21, C9), SCNVector3( C92, -C21, -C9), SCNVector3(-C92, -C21, C9), SCNVector3(-C92, C21, -C9), SCNVector3( C9, C92, C21), SCNVector3( C9, -C92, -C21), SCNVector3( -C9, -C92, C21), SCNVector3( -C9, C92, -C21), SCNVector3( C12, -C19, C91), SCNVector3( C12, C19, -C91), SCNVector3(-C12, C19, C91), SCNVector3(-C12, -C19, -C91), SCNVector3( C91, -C12, C19), SCNVector3( C91, C12, -C19), SCNVector3(-C91, C12, C19), SCNVector3(-C91, -C12, -C19), SCNVector3( C19, -C91, C12), SCNVector3( C19, C91, -C12), SCNVector3(-C19, C91, C12), SCNVector3(-C19, -C91, -C12), SCNVector3( C26, -C5, C90), SCNVector3( C26, C5, -C90), SCNVector3(-C26, C5, C90), SCNVector3(-C26, -C5, -C90), SCNVector3( C90, -C26, C5), SCNVector3( C90, C26, -C5), SCNVector3(-C90, C26, C5), SCNVector3(-C90, -C26, -C5), SCNVector3( C5, -C90, C26), SCNVector3( C5, C90, -C26), SCNVector3( -C5, C90, C26), SCNVector3( -C5, -C90, -C26), SCNVector3( C16, C28, C89), SCNVector3( C16, -C28, -C89), SCNVector3(-C16, -C28, C89), SCNVector3(-C16, C28, -C89), SCNVector3( C89, C16, C28), SCNVector3( C89, -C16, -C28), SCNVector3(-C89, -C16, C28), SCNVector3(-C89, C16, -C28), SCNVector3( C28, C89, C16), SCNVector3( C28, -C89, -C16), SCNVector3(-C28, -C89, C16), SCNVector3(-C28, C89, -C16), SCNVector3( 0.0, C32, C88), SCNVector3( 0.0, C32, -C88), SCNVector3( 0.0, -C32, C88), SCNVector3( 0.0, -C32, -C88), SCNVector3( C88, 0.0, C32), SCNVector3( C88, 0.0, -C32), SCNVector3(-C88, 0.0, C32), SCNVector3(-C88, 0.0, -C32), SCNVector3( C32, C88, 0.0), SCNVector3( C32, -C88, 0.0), SCNVector3(-C32, C88, 0.0), SCNVector3(-C32, -C88, 0.0), SCNVector3( C35, C4, C87), SCNVector3( C35, -C4, -C87), SCNVector3(-C35, -C4, C87), SCNVector3(-C35, C4, -C87), SCNVector3( C87, C35, C4), SCNVector3( C87, -C35, -C4), SCNVector3(-C87, -C35, C4), SCNVector3(-C87, C35, -C4), SCNVector3( C4, C87, C35), SCNVector3( C4, -C87, -C35), SCNVector3( -C4, -C87, C35), SCNVector3( -C4, C87, -C35), SCNVector3( C30, -C23, C86), SCNVector3( C30, C23, -C86), SCNVector3(-C30, C23, C86), SCNVector3(-C30, -C23, -C86), SCNVector3( C86, -C30, C23), SCNVector3( C86, C30, -C23), SCNVector3(-C86, C30, C23), SCNVector3(-C86, -C30, -C23), SCNVector3( C23, -C86, C30), SCNVector3( C23, C86, -C30), SCNVector3(-C23, C86, C30), SCNVector3(-C23, -C86, -C30), SCNVector3( C33, C20, C85), SCNVector3( C33, -C20, -C85), SCNVector3(-C33, -C20, C85), SCNVector3(-C33, C20, -C85), SCNVector3( C85, C33, C20), SCNVector3( C85, -C33, -C20), SCNVector3(-C85, -C33, C20), SCNVector3(-C85, C33, -C20), SCNVector3( C20, C85, C33), SCNVector3( C20, -C85, -C33), SCNVector3(-C20, -C85, C33), SCNVector3(-C20, C85, -C33), SCNVector3( C17, -C36, C84), SCNVector3( C17, C36, -C84), SCNVector3(-C17, C36, C84), SCNVector3(-C17, -C36, -C84), SCNVector3( C84, -C17, C36), SCNVector3( C84, C17, -C36), SCNVector3(-C84, C17, C36), SCNVector3(-C84, -C17, -C36), SCNVector3( C36, -C84, C17), SCNVector3( C36, C84, -C17), SCNVector3(-C36, C84, C17), SCNVector3(-C36, -C84, -C17), SCNVector3( C42, -C10, C83), SCNVector3( C42, C10, -C83), SCNVector3(-C42, C10, C83), SCNVector3(-C42, -C10, -C83), SCNVector3( C83, -C42, C10), SCNVector3( C83, C42, -C10), SCNVector3(-C83, C42, C10), SCNVector3(-C83, -C42, -C10), SCNVector3( C10, -C83, C42), SCNVector3( C10, C83, -C42), SCNVector3(-C10, C83, C42), SCNVector3(-C10, -C83, -C42), SCNVector3( C13, C44, C82), SCNVector3( C13, -C44, -C82), SCNVector3(-C13, -C44, C82), SCNVector3(-C13, C44, -C82), SCNVector3( C82, C13, C44), SCNVector3( C82, -C13, -C44), SCNVector3(-C82, -C13, C44), SCNVector3(-C82, C13, -C44), SCNVector3( C44, C82, C13), SCNVector3( C44, -C82, -C13), SCNVector3(-C44, -C82, C13), SCNVector3(-C44, C82, -C13), SCNVector3( C31, C38, C81), SCNVector3( C31, -C38, -C81), SCNVector3(-C31, -C38, C81), SCNVector3(-C31, C38, -C81), SCNVector3( C81, C31, C38), SCNVector3( C81, -C31, -C38), SCNVector3(-C81, -C31, C38), SCNVector3(-C81, C31, -C38), SCNVector3( C38, C81, C31), SCNVector3( C38, -C81, -C31), SCNVector3(-C38, -C81, C31), SCNVector3(-C38, C81, -C31), SCNVector3( C49, 0.0, C80), SCNVector3( C49, 0.0, -C80), SCNVector3(-C49, 0.0, C80), SCNVector3(-C49, 0.0, -C80), SCNVector3( C80, C49, 0.0), SCNVector3( C80, -C49, 0.0), SCNVector3(-C80, C49, 0.0), SCNVector3(-C80, -C49, 0.0), SCNVector3( 0.0, C80, C49), SCNVector3( 0.0, C80, -C49), SCNVector3( 0.0, -C80, C49), SCNVector3( 0.0, -C80, -C49), SCNVector3( C2, -C50, C79), SCNVector3( C2, C50, -C79), SCNVector3( -C2, C50, C79), SCNVector3( -C2, -C50, -C79), SCNVector3( C79, -C2, C50), SCNVector3( C79, C2, -C50), SCNVector3(-C79, C2, C50), SCNVector3(-C79, -C2, -C50), SCNVector3( C50, -C79, C2), SCNVector3( C50, C79, -C2), SCNVector3(-C50, C79, C2), SCNVector3(-C50, -C79, -C2), SCNVector3( C48, C14, C78), SCNVector3( C48, -C14, -C78), SCNVector3(-C48, -C14, C78), SCNVector3(-C48, C14, -C78), SCNVector3( C78, C48, C14), SCNVector3( C78, -C48, -C14), SCNVector3(-C78, -C48, C14), SCNVector3(-C78, C48, -C14), SCNVector3( C14, C78, C48), SCNVector3( C14, -C78, -C48), SCNVector3(-C14, -C78, C48), SCNVector3(-C14, C78, -C48), SCNVector3( C34, -C40, C77), SCNVector3( C34, C40, -C77), SCNVector3(-C34, C40, C77), SCNVector3(-C34, -C40, -C77), SCNVector3( C77, -C34, C40), SCNVector3( C77, C34, -C40), SCNVector3(-C77, C34, C40), SCNVector3(-C77, -C34, -C40), SCNVector3( C40, -C77, C34), SCNVector3( C40, C77, -C34), SCNVector3(-C40, C77, C34), SCNVector3(-C40, -C77, -C34), SCNVector3( C45, -C25, C76), SCNVector3( C45, C25, -C76), SCNVector3(-C45, C25, C76), SCNVector3(-C45, -C25, -C76), SCNVector3( C76, -C45, C25), SCNVector3( C76, C45, -C25), SCNVector3(-C76, C45, C25), SCNVector3(-C76, -C45, -C25), SCNVector3( C25, -C76, C45), SCNVector3( C25, C76, -C45), SCNVector3(-C25, C76, C45), SCNVector3(-C25, -C76, -C45), SCNVector3( C46, C29, C75), SCNVector3( C46, -C29, -C75), SCNVector3(-C46, -C29, C75), SCNVector3(-C46, C29, -C75), SCNVector3( C75, C46, C29), SCNVector3( C75, -C46, -C29), SCNVector3(-C75, -C46, C29), SCNVector3(-C75, C46, -C29), SCNVector3( C29, C75, C46), SCNVector3( C29, -C75, -C46), SCNVector3(-C29, -C75, C46), SCNVector3(-C29, C75, -C46), SCNVector3( C56, -C11, C74), SCNVector3( C56, C11, -C74), SCNVector3(-C56, C11, C74), SCNVector3(-C56, -C11, -C74), SCNVector3( C74, -C56, C11), SCNVector3( C74, C56, -C11), SCNVector3(-C74, C56, C11), SCNVector3(-C74, -C56, -C11), SCNVector3( C11, -C74, C56), SCNVector3( C11, C74, -C56), SCNVector3(-C11, C74, C56), SCNVector3(-C11, -C74, -C56), SCNVector3( C22, -C52, C73), SCNVector3( C22, C52, -C73), SCNVector3(-C22, C52, C73), SCNVector3(-C22, -C52, -C73), SCNVector3( C73, -C22, C52), SCNVector3( C73, C22, -C52), SCNVector3(-C73, C22, C52), SCNVector3(-C73, -C22, -C52), SCNVector3( C52, -C73, C22), SCNVector3( C52, C73, -C22), SCNVector3(-C52, C73, C22), SCNVector3(-C52, -C73, -C22), SCNVector3( C58, C1, C72), SCNVector3( C58, -C1, -C72), SCNVector3(-C58, -C1, C72), SCNVector3(-C58, C1, -C72), SCNVector3( C72, C58, C1), SCNVector3( C72, -C58, -C1), SCNVector3(-C72, -C58, C1), SCNVector3(-C72, C58, -C1), SCNVector3( C1, C72, C58), SCNVector3( C1, -C72, -C58), SCNVector3( -C1, -C72, C58), SCNVector3( -C1, C72, -C58), SCNVector3( C7, C59, C71), SCNVector3( C7, -C59, -C71), SCNVector3( -C7, -C59, C71), SCNVector3( -C7, C59, -C71), SCNVector3( C71, C7, C59), SCNVector3( C71, -C7, -C59), SCNVector3(-C71, -C7, C59), SCNVector3(-C71, C7, -C59), SCNVector3( C59, C71, C7), SCNVector3( C59, -C71, -C7), SCNVector3(-C59, -C71, C7), SCNVector3(-C59, C71, -C7), SCNVector3( C27, C55, C70), SCNVector3( C27, -C55, -C70), SCNVector3(-C27, -C55, C70), SCNVector3(-C27, C55, -C70), SCNVector3( C70, C27, C55), SCNVector3( C70, -C27, -C55), SCNVector3(-C70, -C27, C55), SCNVector3(-C70, C27, -C55), SCNVector3( C55, C70, C27), SCNVector3( C55, -C70, -C27), SCNVector3(-C55, -C70, C27), SCNVector3(-C55, C70, -C27), SCNVector3( C60, C18, C69), SCNVector3( C60, -C18, -C69), SCNVector3(-C60, -C18, C69), SCNVector3(-C60, C18, -C69), SCNVector3( C69, C60, C18), SCNVector3( C69, -C60, -C18), SCNVector3(-C69, -C60, C18), SCNVector3(-C69, C60, -C18), SCNVector3( C18, C69, C60), SCNVector3( C18, -C69, -C60), SCNVector3(-C18, -C69, C60), SCNVector3(-C18, C69, -C60), SCNVector3( C43, C47, C68), SCNVector3( C43, -C47, -C68), SCNVector3(-C43, -C47, C68), SCNVector3(-C43, C47, -C68), SCNVector3( C68, C43, C47), SCNVector3( C68, -C43, -C47), SCNVector3(-C68, -C43, C47), SCNVector3(-C68, C43, -C47), SCNVector3( C47, C68, C43), SCNVector3( C47, -C68, -C43), SCNVector3(-C47, -C68, C43), SCNVector3(-C47, C68, -C43), SCNVector3( C6, -C63, C67), SCNVector3( C6, C63, -C67), SCNVector3( -C6, C63, C67), SCNVector3( -C6, -C63, -C67), SCNVector3( C67, -C6, C63), SCNVector3( C67, C6, -C63), SCNVector3(-C67, C6, C63), SCNVector3(-C67, -C6, -C63), SCNVector3( C63, -C67, C6), SCNVector3( C63, C67, -C6), SCNVector3(-C63, C67, C6), SCNVector3(-C63, -C67, -C6), SCNVector3( C51, -C41, C66), SCNVector3( C51, C41, -C66), SCNVector3(-C51, C41, C66), SCNVector3(-C51, -C41, -C66), SCNVector3( C66, -C51, C41), SCNVector3( C66, C51, -C41), SCNVector3(-C66, C51, C41), SCNVector3(-C66, -C51, -C41), SCNVector3( C41, -C66, C51), SCNVector3( C41, C66, -C51), SCNVector3(-C41, C66, C51), SCNVector3(-C41, -C66, -C51), SCNVector3( C61, -C24, C65), SCNVector3( C61, C24, -C65), SCNVector3(-C61, C24, C65), SCNVector3(-C61, -C24, -C65), SCNVector3( C65, -C61, C24), SCNVector3( C65, C61, -C24), SCNVector3(-C65, C61, C24), SCNVector3(-C65, -C61, -C24), SCNVector3( C24, -C65, C61), SCNVector3( C24, C65, -C61), SCNVector3(-C24, C65, C61), SCNVector3(-C24, -C65, -C61), SCNVector3( C39, -C54, C64), SCNVector3( C39, C54, -C64), SCNVector3(-C39, C54, C64), SCNVector3(-C39, -C54, -C64), SCNVector3( C64, -C39, C54), SCNVector3( C64, C39, -C54), SCNVector3(-C64, C39, C54), SCNVector3(-C64, -C39, -C54), SCNVector3( C54, -C64, C39), SCNVector3( C54, C64, -C39), SCNVector3(-C54, C64, C39), SCNVector3(-C54, -C64, -C39), SCNVector3( C57, C37, C62), SCNVector3( C57, -C37, -C62), SCNVector3(-C57, -C37, C62), SCNVector3(-C57, C37, -C62), SCNVector3( C62, C57, C37), SCNVector3( C62, -C57, -C37), SCNVector3(-C62, -C57, C37), SCNVector3(-C62, C57, -C37), SCNVector3( C37, C62, C57), SCNVector3( C37, -C62, -C57), SCNVector3(-C37, -C62, C57), SCNVector3(-C37, C62, -C57), SCNVector3( C53, C53, C53), SCNVector3( C53, C53, -C53), SCNVector3( C53, -C53, C53), SCNVector3( C53, -C53, -C53), SCNVector3(-C53, C53, C53), SCNVector3(-C53, C53, -C53), SCNVector3(-C53, -C53, C53), SCNVector3(-C53, -C53, -C53)]
    }
    
    public func generateFaces() -> [Int] {
        return [12, 60, 72 , 13, 61, 75 , 14, 62, 74 , 15, 63, 73 , 16, 64, 76 , 17, 65, 77 , 18, 66, 78 , 19, 67, 79 , 20, 68, 80 , 21, 69, 81 , 22, 70, 83 , 23, 71, 82 , 36, 74, 120 , 37, 73, 121 , 38, 72, 122 , 39, 75, 123 , 40, 76, 124 , 41, 77, 125 , 42, 78, 126 , 43, 79, 127 , 44, 81, 128 , 45, 80, 129 , 46, 82, 130 , 47, 83, 131 , 144, 182, 72 , 145, 183, 75 , 146, 180, 74 , 147, 181, 73 , 148, 184, 76 , 149, 185, 77 , 150, 186, 78 , 151, 187, 79 , 152, 189, 80 , 153, 188, 81 , 154, 191, 83 , 155, 190, 82 , 312, 372, 384 , 313, 373, 387 , 314, 374, 390 , 315, 375, 389 , 316, 376, 384 , 317, 377, 387 , 318, 378, 390 , 319, 379, 389 , 320, 380, 384 , 321, 381, 387 , 322, 382, 390 , 323, 383, 389 , 336, 386, 364 , 337, 385, 365 , 338, 388, 366 , 339, 391, 367 , 340, 386, 368 , 341, 385, 369 , 342, 388, 370 , 343, 391, 371 , 344, 386, 360 , 345, 385, 361 , 346, 388, 362 , 347, 391, 363 , 12, 72, 38 , 13, 75, 39 , 14, 74, 36 , 15, 73, 37 , 16, 76, 40 , 17, 77, 41 , 18, 78, 42 , 19, 79, 43 , 20, 80, 45 , 21, 81, 44 , 22, 83, 47 , 23, 82, 46 , 60, 144, 72 , 61, 145, 75 , 62, 146, 74 , 63, 147, 73 , 64, 148, 76 , 65, 149, 77 , 66, 150, 78 , 67, 151, 79 , 68, 152, 80 , 69, 153, 81 , 70, 154, 83 , 71, 155, 82 , 120, 74, 180 , 121, 73, 181 , 122, 72, 182 , 123, 75, 183 , 124, 76, 184 , 125, 77, 185 , 126, 78, 186 , 127, 79, 187 , 128, 81, 188 , 129, 80, 189 , 130, 82, 190 , 131, 83, 191 , 312, 384, 380 , 313, 387, 381 , 314, 390, 382 , 315, 389, 383 , 316, 384, 372 , 317, 387, 373 , 318, 390, 374 , 319, 389, 375 , 320, 384, 376 , 321, 387, 377 , 322, 390, 378 , 323, 389, 379 , 336, 360, 386 , 337, 361, 385 , 338, 362, 388 , 339, 363, 391 , 340, 364, 386 , 341, 365, 385 , 342, 366, 388 , 343, 367, 391 , 344, 368, 386 , 345, 369, 385 , 346, 370, 388 , 347, 371, 391 , 12, 38, 2 , 13, 39, 3 , 14, 36, 0 , 15, 37, 1 , 16, 40, 4 , 17, 41, 5 , 18, 42, 6 , 19, 43, 7 , 20, 45, 9 , 21, 44, 8 , 22, 47, 11 , 23, 46, 10 , 60, 156, 144 , 61, 157, 145 , 62, 158, 146 , 63, 159, 147 , 64, 160, 148 , 65, 161, 149 , 66, 162, 150 , 67, 163, 151 , 68, 164, 152 , 69, 165, 153 , 70, 166, 154 , 71, 167, 155 , 120, 180, 252 , 121, 181, 253 , 122, 182, 254 , 123, 183, 255 , 124, 184, 256 , 125, 185, 257 , 126, 186, 258 , 127, 187, 259 , 128, 188, 260 , 129, 189, 261 , 130, 190, 262 , 131, 191, 263 , 312, 380, 288 , 313, 381, 289 , 314, 382, 290 , 315, 383, 291 , 316, 372, 292 , 317, 373, 293 , 318, 374, 294 , 319, 375, 295 , 320, 376, 296 , 321, 377, 297 , 322, 378, 298 , 323, 379, 299 , 336, 204, 360 , 337, 205, 361 , 338, 206, 362 , 339, 207, 363 , 340, 208, 364 , 341, 209, 365 , 342, 210, 366 , 343, 211, 367 , 344, 212, 368 , 345, 213, 369 , 346, 214, 370 , 347, 215, 371 , 36, 48, 0 , 37, 49, 1 , 38, 50, 2 , 39, 51, 3 , 40, 52, 4 , 41, 53, 5 , 42, 54, 6 , 43, 55, 7 , 44, 56, 8 , 45, 57, 9 , 46, 58, 10 , 47, 59, 11 , 60, 108, 156 , 61, 109, 157 , 62, 110, 158 , 63, 111, 159 , 64, 112, 160 , 65, 113, 161 , 66, 114, 162 , 67, 115, 163 , 68, 116, 164 , 69, 117, 165 , 70, 118, 166 , 71, 119, 167 , 180, 324, 252 , 181, 325, 253 , 182, 326, 254 , 183, 327, 255 , 184, 328, 256 , 185, 329, 257 , 186, 330, 258 , 187, 331, 259 , 188, 332, 260 , 189, 333, 261 , 190, 334, 262 , 191, 335, 263 , 216, 204, 336 , 217, 205, 337 , 218, 206, 338 , 219, 207, 339 , 220, 208, 340 , 221, 209, 341 , 222, 210, 342 , 223, 211, 343 , 224, 212, 344 , 225, 213, 345 , 226, 214, 346 , 227, 215, 347 , 300, 292, 372 , 301, 293, 373 , 302, 294, 374 , 303, 295, 375 , 304, 296, 376 , 305, 297, 377 , 306, 298, 378 , 307, 299, 379 , 308, 288, 380 , 309, 289, 381 , 310, 290, 382 , 311, 291, 383 , 12, 24, 60 , 13, 25, 61 , 14, 26, 62 , 15, 27, 63 , 16, 28, 64 , 17, 29, 65 , 18, 30, 66 , 19, 31, 67 , 20, 32, 68 , 21, 33, 69 , 22, 34, 70 , 23, 35, 71 , 36, 120, 96 , 37, 121, 97 , 38, 122, 98 , 39, 123, 99 , 40, 124, 100 , 41, 125, 101 , 42, 126, 102 , 43, 127, 103 , 44, 128, 104 , 45, 129, 105 , 46, 130, 106 , 47, 131, 107 , 144, 276, 182 , 145, 277, 183 , 146, 278, 180 , 147, 279, 181 , 148, 280, 184 , 149, 281, 185 , 150, 282, 186 , 151, 283, 187 , 152, 284, 189 , 153, 285, 188 , 154, 286, 191 , 155, 287, 190 , 228, 372, 312 , 229, 373, 313 , 230, 374, 314 , 231, 375, 315 , 232, 376, 316 , 233, 377, 317 , 234, 378, 318 , 235, 379, 319 , 236, 380, 320 , 237, 381, 321 , 238, 382, 322 , 239, 383, 323 , 336, 364, 348 , 337, 365, 349 , 338, 366, 350 , 339, 367, 351 , 340, 368, 352 , 341, 369, 353 , 342, 370, 354 , 343, 371, 355 , 344, 360, 356 , 345, 361, 357 , 346, 362, 358 , 347, 363, 359 , 24, 108, 60 , 25, 109, 61 , 26, 110, 62 , 27, 111, 63 , 28, 112, 64 , 29, 113, 65 , 30, 114, 66 , 31, 115, 67 , 32, 116, 68 , 33, 117, 69 , 34, 118, 70 , 35, 119, 71 , 36, 96, 48 , 37, 97, 49 , 38, 98, 50 , 39, 99, 51 , 40, 100, 52 , 41, 101, 53 , 42, 102, 54 , 43, 103, 55 , 44, 104, 56 , 45, 105, 57 , 46, 106, 58 , 47, 107, 59 , 180, 278, 324 , 181, 279, 325 , 182, 276, 326 , 183, 277, 327 , 184, 280, 328 , 185, 281, 329 , 186, 282, 330 , 187, 283, 331 , 188, 285, 332 , 189, 284, 333 , 190, 287, 334 , 191, 286, 335 , 216, 336, 348 , 217, 337, 349 , 218, 338, 350 , 219, 339, 351 , 220, 340, 352 , 221, 341, 353 , 222, 342, 354 , 223, 343, 355 , 224, 344, 356 , 225, 345, 357 , 226, 346, 358 , 227, 347, 359 , 228, 300, 372 , 229, 301, 373 , 230, 302, 374 , 231, 303, 375 , 232, 304, 376 , 233, 305, 377 , 234, 306, 378 , 235, 307, 379 , 236, 308, 380 , 237, 309, 381 , 238, 310, 382 , 239, 311, 383 , 24, 84, 108 , 25, 85, 109 , 26, 86, 110 , 27, 87, 111 , 28, 88, 112 , 29, 89, 113 , 30, 90, 114 , 31, 91, 115 , 32, 92, 116 , 33, 93, 117 , 34, 94, 118 , 35, 95, 119 , 48, 96, 132 , 49, 97, 133 , 50, 98, 134 , 51, 99, 135 , 52, 100, 136 , 53, 101, 137 , 54, 102, 138 , 55, 103, 139 , 56, 104, 140 , 57, 105, 141 , 58, 106, 142 , 59, 107, 143 , 216, 348, 240 , 217, 349, 241 , 218, 350, 242 , 219, 351, 243 , 220, 352, 244 , 221, 353, 245 , 222, 354, 246 , 223, 355, 247 , 224, 356, 248 , 225, 357, 249 , 226, 358, 250 , 227, 359, 251 , 228, 192, 300 , 229, 193, 301 , 230, 194, 302 , 231, 195, 303 , 232, 196, 304 , 233, 197, 305 , 234, 198, 306 , 235, 199, 307 , 236, 200, 308 , 237, 201, 309 , 238, 202, 310 , 239, 203, 311 , 276, 272, 326 , 277, 273, 327 , 278, 274, 324 , 279, 275, 325 , 280, 264, 328 , 281, 265, 329 , 282, 266, 330 , 283, 267, 331 , 284, 268, 333 , 285, 269, 332 , 286, 270, 335 , 287, 271, 334 , 168, 84, 132 , 168, 132, 240 , 168, 192, 84 , 168, 240, 264 , 168, 264, 192 , 169, 85, 133 , 169, 133, 241 , 169, 193, 85 , 169, 241, 265 , 169, 265, 193 , 170, 86, 134 , 170, 134, 242 , 170, 194, 86 , 170, 242, 266 , 170, 266, 194 , 171, 87, 135 , 171, 135, 243 , 171, 195, 87 , 171, 243, 267 , 171, 267, 195 , 172, 88, 137 , 172, 137, 245 , 172, 196, 88 , 172, 245, 268 , 172, 268, 196 , 173, 89, 136 , 173, 136, 244 , 173, 197, 89 , 173, 244, 269 , 173, 269, 197 , 174, 91, 138 , 174, 138, 246 , 174, 199, 91 , 174, 246, 271 , 174, 271, 199 , 175, 90, 139 , 175, 139, 247 , 175, 198, 90 , 175, 247, 270 , 175, 270, 198 , 176, 92, 142 , 176, 142, 250 , 176, 200, 92 , 176, 250, 272 , 176, 272, 200 , 177, 95, 141 , 177, 141, 249 , 177, 203, 95 , 177, 249, 275 , 177, 275, 203 , 178, 94, 140 , 178, 140, 248 , 178, 202, 94 , 178, 248, 274 , 178, 274, 202 , 179, 93, 143 , 179, 143, 251 , 179, 201, 93 , 179, 251, 273 , 179, 273, 201 , 48, 132, 84 , 49, 133, 85 , 50, 134, 86 , 51, 135, 87 , 52, 136, 89 , 53, 137, 88 , 54, 138, 91 , 55, 139, 90 , 56, 140, 94 , 57, 141, 95 , 58, 142, 92 , 59, 143, 93 , 108, 84, 192 , 109, 85, 193 , 110, 86, 194 , 111, 87, 195 , 112, 88, 196 , 113, 89, 197 , 114, 90, 198 , 115, 91, 199 , 116, 92, 200 , 117, 93, 201 , 118, 94, 202 , 119, 95, 203 , 216, 240, 132 , 217, 241, 133 , 218, 242, 134 , 219, 243, 135 , 220, 244, 136 , 221, 245, 137 , 222, 246, 138 , 223, 247, 139 , 224, 248, 140 , 225, 249, 141 , 226, 250, 142 , 227, 251, 143 , 300, 192, 264 , 301, 193, 265 , 302, 194, 266 , 303, 195, 267 , 304, 196, 268 , 305, 197, 269 , 306, 198, 270 , 307, 199, 271 , 308, 200, 272 , 309, 201, 273 , 310, 202, 274 , 311, 203, 275 , 324, 274, 248 , 325, 275, 249 , 326, 272, 250 , 327, 273, 251 , 328, 264, 240 , 329, 265, 241 , 330, 266, 242 , 331, 267, 243 , 332, 269, 244 , 333, 268, 245 , 334, 271, 246 , 335, 270, 247 , 24, 48, 84 , 25, 49, 85 , 26, 50, 86 , 27, 51, 87 , 28, 53, 88 , 29, 52, 89 , 30, 55, 90 , 31, 54, 91 , 32, 58, 92 , 33, 59, 93 , 34, 56, 94 , 35, 57, 95 , 96, 216, 132 , 97, 217, 133 , 98, 218, 134 , 99, 219, 135 , 100, 220, 136 , 101, 221, 137 , 102, 222, 138 , 103, 223, 139 , 104, 224, 140 , 105, 225, 141 , 106, 226, 142 , 107, 227, 143 , 108, 192, 228 , 109, 193, 229 , 110, 194, 230 , 111, 195, 231 , 112, 196, 232 , 113, 197, 233 , 114, 198, 234 , 115, 199, 235 , 116, 200, 236 , 117, 201, 237 , 118, 202, 238 , 119, 203, 239 , 276, 308, 272 , 277, 309, 273 , 278, 310, 274 , 279, 311, 275 , 280, 300, 264 , 281, 301, 265 , 282, 302, 266 , 283, 303, 267 , 284, 304, 268 , 285, 305, 269 , 286, 306, 270 , 287, 307, 271 , 324, 248, 356 , 325, 249, 357 , 326, 250, 358 , 327, 251, 359 , 328, 240, 348 , 329, 241, 349 , 330, 242, 350 , 331, 243, 351 , 332, 244, 352 , 333, 245, 353 , 334, 246, 354 , 335, 247, 355 , 24, 0, 48 , 25, 1, 49 , 26, 2, 50 , 27, 3, 51 , 28, 5, 53 , 29, 4, 52 , 30, 7, 55 , 31, 6, 54 , 32, 10, 58 , 33, 11, 59 , 34, 8, 56 , 35, 9, 57 , 96, 204, 216 , 97, 205, 217 , 98, 206, 218 , 99, 207, 219 , 100, 208, 220 , 101, 209, 221 , 102, 210, 222 , 103, 211, 223 , 104, 212, 224 , 105, 213, 225 , 106, 214, 226 , 107, 215, 227 , 108, 228, 156 , 109, 229, 157 , 110, 230, 158 , 111, 231, 159 , 112, 232, 160 , 113, 233, 161 , 114, 234, 162 , 115, 235, 163 , 116, 236, 164 , 117, 237, 165 , 118, 238, 166 , 119, 239, 167 , 276, 288, 308 , 277, 289, 309 , 278, 290, 310 , 279, 291, 311 , 280, 292, 300 , 281, 293, 301 , 282, 294, 302 , 283, 295, 303 , 284, 296, 304 , 285, 297, 305 , 286, 298, 306 , 287, 299, 307 , 324, 356, 252 , 325, 357, 253 , 326, 358, 254 , 327, 359, 255 , 328, 348, 256 , 329, 349, 257 , 330, 350, 258 , 331, 351, 259 , 332, 352, 260 , 333, 353, 261 , 334, 354, 262 , 335, 355, 263 , 12, 0, 24 , 13, 1, 25 , 14, 2, 26 , 15, 3, 27 , 16, 5, 28 , 17, 4, 29 , 18, 7, 30 , 19, 6, 31 , 20, 10, 32 , 21, 11, 33 , 22, 8, 34 , 23, 9, 35 , 96, 120, 204 , 97, 121, 205 , 98, 122, 206 , 99, 123, 207 , 100, 124, 208 , 101, 125, 209 , 102, 126, 210 , 103, 127, 211 , 104, 128, 212 , 105, 129, 213 , 106, 130, 214 , 107, 131, 215 , 144, 288, 276 , 145, 289, 277 , 146, 290, 278 , 147, 291, 279 , 148, 292, 280 , 149, 293, 281 , 150, 294, 282 , 151, 295, 283 , 152, 296, 284 , 153, 297, 285 , 154, 298, 286 , 155, 299, 287 , 228, 312, 156 , 229, 313, 157 , 230, 314, 158 , 231, 315, 159 , 232, 316, 160 , 233, 317, 161 , 234, 318, 162 , 235, 319, 163 , 236, 320, 164 , 237, 321, 165 , 238, 322, 166 , 239, 323, 167 , 348, 364, 256 , 349, 365, 257 , 350, 366, 258 , 351, 367, 259 , 352, 368, 260 , 353, 369, 261 , 354, 370, 262 , 355, 371, 263 , 356, 360, 252 , 357, 361, 253 , 358, 362, 254 , 359, 363, 255 , 12, 2, 0 , 13, 3, 1 , 14, 0, 2 , 15, 1, 3 , 16, 4, 5 , 17, 5, 4 , 18, 6, 7 , 19, 7, 6 , 20, 9, 10 , 21, 8, 11 , 22, 11, 8 , 23, 10, 9 , 120, 252, 204 , 121, 253, 205 , 122, 254, 206 , 123, 255, 207 , 124, 256, 208 , 125, 257, 209 , 126, 258, 210 , 127, 259, 211 , 128, 260, 212 , 129, 261, 213 , 130, 262, 214 , 131, 263, 215 , 144, 156, 288 , 145, 157, 289 , 146, 158, 290 , 147, 159, 291 , 148, 160, 292 , 149, 161, 293 , 150, 162, 294 , 151, 163, 295 , 152, 164, 296 , 153, 165, 297 , 154, 166, 298 , 155, 167, 299 , 312, 288, 156 , 313, 289, 157 , 314, 290, 158 , 315, 291, 159 , 316, 292, 160 , 317, 293, 161 , 318, 294, 162 , 319, 295, 163 , 320, 296, 164 , 321, 297, 165 , 322, 298, 166 , 323, 299, 167 , 360, 204, 252 , 361, 205, 253 , 362, 206, 254 , 363, 207, 255 , 364, 208, 256 , 365, 209, 257 , 366, 210, 258 , 367, 211, 259 , 368, 212, 260 , 369, 213, 261 , 370, 214, 262 , 371, 215, 263]
    }
    
}
