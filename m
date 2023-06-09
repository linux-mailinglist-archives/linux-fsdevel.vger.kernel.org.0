Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE17729FA6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbjFIQJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 12:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFIQJW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:09:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDE3588;
        Fri,  9 Jun 2023 09:09:15 -0700 (PDT)
X-UUID: f62db8fc06df11eeb20a276fd37b9834-20230610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Cz5NBp7QtSBLOEccUPF6FQvSc+bl/jvNZWISLJMne/c=;
        b=MIf932PcX1l7qQnSeoxwyrFicsDt1G9wBn64RKGSCjgwt7S2/JXLDoZKTwNKuflTDMdZrtbjqD0p2IfNIoEnUSsorHGmNg8+75XL+M38iGTosz2o6iVY53BFZMJckjgttt5N34LdtQpXczoqwyC5o676sxmWUzme9Vg0GtRHbnA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:389210af-de1a-49d3-bfc2-4fd7b115e592,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:0b12f33d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f62db8fc06df11eeb20a276fd37b9834-20230610
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <wei-chin.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2121028256; Sat, 10 Jun 2023 00:09:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 10 Jun 2023 00:09:06 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 10 Jun 2023 00:09:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dwy9zmdhbM8NJha+cUPumo6fOKRl4GpVGOSgcodK9ZDjdtVz52y1+Viq7ZDqHejV6ipwwHi2L8Wh7mQi9QG0j2YVoEKDKRYlNIrloOJtnBkHE4NYg+NfqO0v7cTmAbuizCG/XUNaXIEr3g3WWTUPlJx250Saeth+XUvu80fN2UpJF4Klk+CXYEgxjimkESvvN1BGDPEe0+tF2kTbksSgyyvikMi9jc6zYOBzpMCtaxxJopMu7RHKntFhM3P6sfJgQAs29BVu4EsBccB0tb3D48BOjo2eu6tiB/ZFql82K55hwE2RZWUKpuporWxYGMrWSL8oibZtpGBI5lQAu92jMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz5NBp7QtSBLOEccUPF6FQvSc+bl/jvNZWISLJMne/c=;
 b=E64QrnmyvZYHciYnZL1+F6kytJbo82nFSe5Ekq9vnfXflM35FrRqVtYHBV2Qd398rfBeF/TpHFV+EJls91kSoXhjQKIx2UhJNW6xjQFPQEGXfy7ltJMJcThhj/R28NsGudE587Z96r0DPRw/854yAAzPCVutqTdLHZ6GI6mqvbHX7lMLN/jvUrwiImHofkudTTVQjoetjvLl6dfSfOfbUVWvcwqN+g2rA9KuQC/BM/VewaF10ZEoWlB0HS1/5bcwarU/EELj6Q9D2liO41pYKWEDf8FHPVUMdwQvpO21L2m+S+EbUUr/pMRoPRFCfvxspd2ckZoe7lrJF4DU0dDbCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz5NBp7QtSBLOEccUPF6FQvSc+bl/jvNZWISLJMne/c=;
 b=IzLSocB4CA8knZz/Ljw8kQUrQ6TOcaXlfgr8c3fo2wJbTyxhW5GUV+zvb6yMzheACrnL6PL7s1/lqq+K7b5S8z8QUZptvQf2h3VSW1w9XzsBLIktwr6G3z49CztP+jytVPKwiIWtOkBZb0ifBdNWFXHPedq6ttwz14dVRCPg2lc=
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com (2603:1096:990:37::13)
 by PUZPR03MB6045.apcprd03.prod.outlook.com (2603:1096:301:b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 9 Jun
 2023 16:09:01 +0000
Received: from JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd]) by JH0PR03MB8100.apcprd03.prod.outlook.com
 ([fe80::56de:54d6:38f2:afcd%6]) with mapi id 15.20.6455.037; Fri, 9 Jun 2023
 16:09:01 +0000
From:   =?utf-8?B?V2VpLWNoaW4gVHNhaSAo6JSh57at5pmJKQ==?= 
        <Wei-chin.Tsai@mediatek.com>
To:     "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWVsIExlZSAo5p2O5aWH6YyaKQ==?= <Mel.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?SXZhbiBUc2VuZyAo5pu+5b+X6LuSKQ==?= 
        <ivan.tseng@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 1/1] memory: export symbols for process memory related
 functions
Thread-Topic: [PATCH v1 1/1] memory: export symbols for process memory related
 functions
Thread-Index: AQHZmsLfKGM6En7+PEKHCKj76a3bLq+CUzuAgABQpgA=
Date:   Fri, 9 Jun 2023 16:09:01 +0000
Message-ID: <5cc76704214673cf03376d9f10f61325b9ed323f.camel@mediatek.com>
References: <20230609110902.13799-1-Wei-chin.Tsai@mediatek.com>
         <ZIMK9QV5+ce69Shr@shell.armlinux.org.uk>
In-Reply-To: <ZIMK9QV5+ce69Shr@shell.armlinux.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB8100:EE_|PUZPR03MB6045:EE_
x-ms-office365-filtering-correlation-id: 3753e5fe-0f91-4890-4688-08db6903d6db
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+WAnITnur1u7aFOYqRwVxZSuLlcDVn3SMzBcq9m7JY9ZruZ9MVEATGpVeO/pXF9yRObQrga1thFby7PrP6zcauMFpbMRCeE19OMhSnbKBI8lr7i/s2/H6357Rp12fuJ0GxXaFtcytntVu+FTX6TWBfuX1Duqcdh5s86iB6pJvAtXa0Yq6w9pMPT1RU9zPVtxJstbMtEHBuGOXJAgPYrAi2TBzEuITwDSA9+vp10xFHL+NhmIueZgON/WIrhL9qgMg9fAWwqHA2rxX8ZdR084p5ViwUtPG7YNvHg31FYkwpy1XyYXbmPkafBKWhfqKM4lSUPxPUXZX1pebo/2HcEVkrmBu9RNRv0SIkL7X4AM4DARk9isYDcoxIGO0BaY/YpIxrP0VWzkDyL0bc2Uam5ChETp0DEPMcOh/a46MqfxS/FOvzqF15lGCEbK+AC7rflsfndqC3PAdhhJpr4sc8Li7McDscCc16apHJM3ab5T8KEWZTiF00M14BVRdK7W4EuZYUQ3Z+JFWAJOd2WJR0/yiaAmgHjps6J6kuCcNlzN1sAdCdXOGEbUy/98HGNkrPSW8jrBepuOpRWCnUWCmcabZdWU7+Ro0rwZmc3w2tDnZshUIzRsl2zhDcRt1qv0Qm2PtKIGjUpJpWT/jGKZOUuBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB8100.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(2616005)(54906003)(122000001)(91956017)(478600001)(8936002)(38100700002)(8676002)(5660300002)(4326008)(66476007)(76116006)(316002)(66446008)(66556008)(64756008)(66946007)(6916009)(41300700001)(186003)(83380400001)(966005)(6486002)(71200400001)(6506007)(26005)(6512007)(86362001)(38070700005)(36756003)(85182001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1EraGtRZVZxSFRJKzFGMC9XVmdGWWd6VlZ2aTlVWHAyQlRXa3JZYzNuUkNC?=
 =?utf-8?B?eTRLZW1wQ0VQR1dEU0Y4MHJITVErenNuQmhkNEJyZ0Q3VENnb3JJRjVXWmpa?=
 =?utf-8?B?YTVxZWx1cmJTVVR3bHJCQ0VlWkdkanByS2JXWE1rdjBJUXdqWXFBam5KQmNX?=
 =?utf-8?B?SWRhdjhGTVVjRlp3aFFLajdCS0hZSThmNmJkRURpbk01aWlMcHRiVWF0TkdZ?=
 =?utf-8?B?Y0FUbnZyVW5iQ012bHdxSmJZQjV1TTUxZTlod0pZSzY0S0NJU2Y2QTNMU1JO?=
 =?utf-8?B?S3NkSFpkZ0xLVWRYVTBmWDZtNlRvWjR2QlM3cnllSUJUUzQxMitJdmc4SVZs?=
 =?utf-8?B?cVV4bUg1UkZIdWJGd3dIekx6R29YUmMwbGVjMUFWZS9Rd0tDQzFsaEhlMjZY?=
 =?utf-8?B?TW9hczhUQ1NEYXRoaXVSYmo5TjB3cU9OWnQwZ3NHMXFORkRCZ2p5T1NVRDhQ?=
 =?utf-8?B?eGZXeTZZTzJiZEg5akhLNGhwQ3JkbHQwV3J0cTRWbmtEVjR0TksxK1ZuKzBk?=
 =?utf-8?B?TjZWOXFiSmlBVjRsNmJqTXE0N0ZjMTZuaUZkNTNUSFlKajA3dGJldy9SME1n?=
 =?utf-8?B?ZjV2S3Fmb0xxYjNPY0Z0aXk4SVdYdHhqZUJlaTFsUk1vN0tJNGNXa1dZYVBl?=
 =?utf-8?B?cThHcmk5eHBMeVVkaVB1dDNYbDJycmNMdC8rS1lnY1dUdklWYTVxcmYyQW5R?=
 =?utf-8?B?aWl3Z1VSZFZKTVVFekpDaUFDaG1uQ2VQNC9hUkZNYkNjV1BzTzVLZktuVVlm?=
 =?utf-8?B?QXUxaEVpUkNpY3JaWGVwTVBwbGRJVEhpeDhZZTc3UDFLcjArblNQU0lxVFRM?=
 =?utf-8?B?VjA4OFBXUFJHbEN1VkREaWN5eHRhOXlzb3hBZXRkd0RRMEw2RWU3dis4ZDg4?=
 =?utf-8?B?OXUyMVhqVExKQ0Fzc3htdGFQK3AxNmU4bithSDBmWHhnejlDYVM0dGNYV09I?=
 =?utf-8?B?dE5xWkI3VStkTXRwNTdMayt5am5XUGFEODNUVnllVXlySEhGRGV3NitEZVl2?=
 =?utf-8?B?TWVZZDlMejBPeFBvZ1NGT1BYbU0rd0hGUXhneDJIRHk1L1NlV3dvWGpaVUN5?=
 =?utf-8?B?WHFIMUJOK0hKUnlCNmlVbVdJR2tuV0ZVQ241QnZiNzFEdDJzdTJFNmFYYzJ5?=
 =?utf-8?B?RzlrRG9aV0M5Z0ZERVlHQXFGVWk1YzJqdlV3SXR1SHNESW4vakgwdjBOekNl?=
 =?utf-8?B?OStZYVBRcWJGTVNGWG03N0tqR1JFeDd0M0lKYzlTckx6aGxqbFN5WHo1STZn?=
 =?utf-8?B?THhOZjlzdGpzZnFmcEQ4WHUrUm5ZUEhHdDNTODFZMkdxYVlmK0o5aDdQRTA4?=
 =?utf-8?B?eENGM1pzNmx6a2JDTmhYdUNXOHluOEFZWmFESWRtUVBxUkgzM0pGUUhlU2Jq?=
 =?utf-8?B?K3REM2EwbFZjWHVid0Rja1pmUGlIL0VuUTU1d0MyWnRlblVuK2cyaWZidVEz?=
 =?utf-8?B?RktXQzVSL2dHL3JEWWw0R0ZjS2ZVVVcvZjFPaC9CNmJVTE9UcWlObEpadzZv?=
 =?utf-8?B?bEtEeVo2M0hKYjllaXphUlFKQ2xpZlRQTVRrTlRmdFpTSjkrYk1tSnZNSlVG?=
 =?utf-8?B?b0haVG1yalhIL0ZDVTRHcUk3cWZ1RjRUdjYyTklEVGNDbUZZUTViam1CRXVx?=
 =?utf-8?B?dkFGWTN2QWtYOW9Kd1I3V2V5SjFYb05yRUlkTGhIbDdIdi9oQU5qWE1EaUVS?=
 =?utf-8?B?Ri94Q3dtUEYwWUxlbU5ObWpSWExBc3UwRzhJTnFBcjBYQU1yQ05nbWJ3Nk1t?=
 =?utf-8?B?NlRmTjc0bHVxT3dmK1lGVTE1K204RjdNcHNZMHBLanpDQTFBSGlvQ0ZSQTRU?=
 =?utf-8?B?Y1J4SU8zSUg5b1dyc0pRTnltclJMZUNkdms4MGRKT255QVlWWldvY2RhMEYz?=
 =?utf-8?B?dGplNXprZ05qcGh6Wk9tYi9RYXp4QTByQS9IbzJzTWN1WEs0bFEveWE4b1Vi?=
 =?utf-8?B?QVF3UFZvWW9ZSzFjWkt6RlRVOWc3MUFuL09BR3krZnFiek5zU0QrMTAwemNV?=
 =?utf-8?B?d2ZkRFZyclZTSjBxU2dGSXhLcjFwazRXSzFTcS9iZS8xeFZOdmFVSkZsZVRl?=
 =?utf-8?B?QjlJVmRyQjRXQnduK3JZV2x5ZUhhKzFENGMzZm5adW9yc0cwdWpZSlNaWFFh?=
 =?utf-8?B?RHJxeUhiZWlrNW5iMDJqSzNUS0ZpQ1NpYlJaWkQyVzJJVXdhdXIyK0l6U214?=
 =?utf-8?B?Z0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD861143143C4142BDB20B8C0E211526@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB8100.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3753e5fe-0f91-4890-4688-08db6903d6db
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 16:09:01.3492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxpsxiW+eczvaaVW9H/BPCLdHu98WW3a0XzV1VYDzpIamgnduVmgjLWcNq2HeiQ+WFdwcS/TPD8uG3nFRTexnlKo7ccLeTal/6r+vMh+1ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTA5IGF0IDEyOjIwICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gRnJpLCBKdW4gMDksIDIwMjMgYXQgMDc6MDk6MDBQ
TSArMDgwMCwgamltLnRzYWkgd3JvdGU6DQo+ID4gRXhwb3J0IHN5bWJvbHMgZm9yIGFyY2hfdm1h
X25hbWUgYW5kIHNtYXBfZ2F0aGVyX3N0YXRzDQo+ID4gZnVuY3Rpb25zIHNvIHRoYXQgd2UgY2Fu
IGRldGVjdCB0aGUgbWVtb3J5IGxlYWsgaXNzdWVzLg0KPiA+IEJlc2lkZXMsIHdlIGNhbiBrbm93
IHdoaWNoIG1lbW9yeSB0eXBlIGlzIGxlYWtlZCwgdG9vLg0KPiANCj4gVGhpcyBjb21taXQgZGVz
Y3JpcHRpb24gZG9lc24ndCBnaXZlIGVub3VnaCBpbmZvcm1hdGlvbi4gSG93IGRvZXMNCj4gZXhw
b3J0aW5nIGFyY2hfdm1hX25hbWUoKSBoZWxwIHdpdGggZGV0ZWN0aW5nIG1lbW9yeSBsZWFrIGlz
c3Vlcz8NCj4gDQo+IFlvdSBoYXZlbid0IGluY2x1ZGVkIGFueSB1c2VycyBvZiB0aGVzZSBuZXcg
ZXhwb3J0cywgc28gdGhlIGluaXRpYWwNCj4gcmVhY3Rpb24gaXMgZ29pbmcgdG8gYmUgbmVnYXRp
dmUgLSBwbGVhc2UgaW5jbHVkZSB0aGUgdXNlcnMgb2YgdGhlc2UNCj4gbmV3IHN5bWJvbHMgaW4g
eW91ciBwYXRjaCBzZXQuDQo+IA0KPiBUaGFua3MuDQo+IA0KPiAtLSANCj4gUk1LJ3MgUGF0Y2gg
c3lzdGVtOiBodHRwczovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvDQo+
IEZUVFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBEZWNlbnQgY29ubmVjdGl2aXR5
IGF0IGxhc3QhDQoNCg0KSGkgUnVzc2VsbCwNCg0KYXJjaF92bWFfbmFtZSgpIGlzIHRvIGdldCB0
aGUgaGVhcCBpbmZyb21hdGlvbiBmcm9tIGEgdXNlciBwcm9jZXNzLg0KDQpXZSB1c2UgdGhlc2Ug
dHdvIGV4cG9ydCBmdW5jdGlvbnMgZnJvbSBvdXIga2VybmVsIG1vZHVsZSB0byBnZXQgYQ0Kc3Bl
Y2lmaWMgdXNlciBwcm9jZXNzJ3MgbWVtb3J5IGluZm9ybWF0aW9uIGFuZCBoZWFwIHVzYWdlLiBG
dXJ0aGVybW9yZSwNCndlIGNhbiB1c2Ugc3VjaCBpbmZvcm1hdGlvbiB0byBkZXRlY3QgdGhlIG1l
bW9yeSBsZWFrIGlzc3Vlcy4gDQoNClRoZSBleGFtcGxlIGNvZGUgaXMgYXMgZm9sbG93czoNCg0K
LypleGFtcGxlIGNvZGUqLw0KDQp2b2lkIG1fbWFwX3ZtYShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSwgdW5zaWduZWQgbG9uZyBjdXJfcHNzLA0KICAgICAgICAgICAgICAgICAgICAgICAgdW5z
aWduZWQgbG9uZyAqbmF0aXZlX2hlYXAsIHVuc2lnbmVkIGxvbmcNCipqYXZhX2hlYXApDQp7DQoJ
c3RydWN0IG1tX3N0cnVjdCAqbW0gPSB2bWEtPnZtX21tOw0KICAgICAgICBjb25zdCBjaGFyICpu
YW1lID0gTlVMTDsNCg0KCS4uLg0KCW5hbWUgPSBhcmNoX3ZtYV9uYW1lKHZtYSk7DQogICAgICAg
IGlmICghbmFtZSkgew0KICAgICAgICAgICAgICAgIHN0cnVjdCBhbm9uX3ZtYV9uYW1lICphbm9u
X25hbWU7DQoNCiAgICAgICAgICAgICAgICAuLi4NCiAgICAgICAgICAgICAgICBhbm9uX25hbWUg
PSBtX2Fub25fdm1hX25hbWUodm1hKTsNCiAgICAgICAgICAgICAgICBpZiAoYW5vbl9uYW1lKSB7
DQogICAgICAgICAgICAgICAgICAgICAgICBpZiAoc3Ryc3RyKGFub25fbmFtZS0+bmFtZSwgInNj
dWRvIikpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgqbmF0aXZlX2hlYXApICs9
IGN1cl9wc3M7DQogICAgICAgICAgICAgICAgICAgICAgICBlbHNlIGlmIChzdHJzdHIoYW5vbl9u
YW1lLT5uYW1lLA0KImxpYmNfbWFsbG9jIikpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICgqbmF0aXZlX2hlYXApICs9IGN1cl9wc3M7DQogICAgICAgICAgICAgICAgICAgICAgICBl
bHNlIGlmIChzdHJzdHIoYW5vbl9uYW1lLT5uYW1lLCAiR1dQLUFTYW4iKSkNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKCpuYXRpdmVfaGVhcCkgKz0gY3VyX3BzczsNCiAgICAgICAg
ICAgICAgICAgICAgICAgIGVsc2UgaWYgKHN0cnN0cihhbm9uX25hbWUtPm5hbWUsICJkYWx2aWst
YWxsb2MNCnNwYWNlIikpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgqamF2YV9o
ZWFwKSArPSBjdXJfcHNzOw0KICAgICAgICAgICAgICAgICAgICAgICAgZWxzZSBpZiAoc3Ryc3Ry
KGFub25fbmFtZS0+bmFtZSwgImRhbHZpay1tYWluDQpzcGFjZSIpKQ0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAoKmphdmFfaGVhcCkgKz0gY3VyX3BzczsNCg0KICAgICAgICAgICAg
ICAgICAgICAgICAgLi4uDQogICAgICAgICAgICAgICAgfQ0KICAgICAgICB9DQp9DQoNCnZvaWQg
Y2FsY3VsYXRlX3Byb2Nlc3NfbWVtb3J5KHN0cnVjdCB0YXNrX3N0cnVjdCAqdCkNCnsNCiAgICAg
ICAgc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBOVUxMOw0KICAgICAgICBzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSA9IE5VTEw7DQogICAgICAgIHN0cnVjdCBtZW1fc2l6ZV9zdGF0cyBtc3M7DQog
ICAgICAgIHVuc2lnbmVkIGxvbmcgcHNzLCB1c3MsIHJzcywgc3dhcCwgY3VyX3BzczsNCiAgICAg
ICAgdW5zaWduZWQgbG9uZyBqYXZhX2hlYXAgPSAwLCBuYXRpdmVfaGVhcCA9IDA7DQogICAgICAg
IHN0cnVjdCB2bWFfaXRlcmF0b3Igdm1pOw0KDQogICAgICAgIGdldF90YXNrX3N0cnVjdCh0KTsN
CiAgICAgICAgbW0gPSB0LT5tbTsNCiAgICAgICAgaWYgKG1tKSB7DQogICAgICAgICAgICAgICAg
bWVtc2V0KCZtc3MsIDAsIHNpemVvZihtc3MpKTsNCiAgICAgICAgICAgICAgICBtbWdyYWIobW0p
Ow0KICAgICAgICAgICAgICAgIG1tYXBfcmVhZF9sb2NrKG1tKTsNCiAgICAgICAgICAgICAgICB2
bWFfaXRlcl9pbml0KCZ2bWksIG1tLCAwKTsNCg0KICAgICAgICAgICAgICAgIGZvcl9lYWNoX3Zt
YSh2bWksIHZtYSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgY3VyX3BzcyA9ICh1bnNpZ25l
ZCBsb25nKShtc3MucHNzID4+DQpQU1NfU0hJRlQpOw0KICAgICAgICAgICAgICAgICAgICAgICAg
c21hcF9nYXRoZXJfc3RhdHModm1hLCAmbXNzLCAwKTsNCiAgICAgICAgICAgICAgICAgICAgICAg
IGN1cl9wc3MgPQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKHVuc2lnbmVkIGxv
bmcpKG1zcy5wc3MgPj4gUFNTX1NISUZUKSkNCi0gY3VyX3BzczsNCiAgICAgICAgICAgICAgICAg
ICAgICAgIGN1cl9wc3MgPSBjdXJfcHNzIC8gMTAyNDsNCiAgICAgICAgICAgICAgICAgICAgICAg
IG1fbWFwX3ZtYSh2bWEsIGN1cl9wc3MsICZuYXRpdmVfaGVhcCwNCiZqYXZhX2hlYXApOw0KICAg
ICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICBtbWFwX3JlYWRfdW5sb2NrKG1tKTsNCiAg
ICAgICAgICAgICAgICBtbWRyb3AobW0pOw0KICAgICAgICB9DQogICAgICAgIHB1dF90YXNrX3N0
cnVjdCh0KTsNCg0KICAgICAgICAuLi4NCn0NCg0KVGhhbmtzDQoNCkppbQ0KDQoNCg==
