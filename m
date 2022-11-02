Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D55615CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 08:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiKBHLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 03:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKBHLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:11:37 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E3186FE;
        Wed,  2 Nov 2022 00:11:35 -0700 (PDT)
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A22tocg015311;
        Wed, 2 Nov 2022 07:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=l2uHTGsMyHlxbrdJ3Hhgv0YxmRF9V6gTmaJe9uNYoxU=;
 b=DvrIpn5vblQNX7pQ/RZ1lJ+J0E9YaWCok+kkKZ+dmSXn9aA0LMyLzMoW/VH2/1kJnhlE
 sbOOzXMFaLT0RcFS1Qjnm84rkjbN7vlrzJnJF22+Evegbw9PMp4ca3Mc3e4tQQiDt/0L
 pTTKm28lrZYyKDClsVVRZAuKhAQLZWjutFPhUVKiUwVvBXhQRjd265TVaxBvga7iAwrX
 NQmh2Uu+krN43prIo2GApQB6h1weNlxe2MMjiLX7nSVNT79ahS6RbbnZwto9zHd0cMhc
 hd2YcCvAF/InB1ULmLEG6jkuIIi+Tg0RLfLYZjVcDHK13nvBNCA7V5RQA/466D/LoqA4 kg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2044.outbound.protection.outlook.com [104.47.26.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kjhf8j0dc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 07:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD0+Fd02S9auKkzSpn/k08/zrmWTsYzozucjodDQIYUZhL/61Au9K7QukpsMqQqu4QdlyvyVU1zvRTfV5q0A01K49Xg3X6N/4U4+JKQbn6mL0n7BfxEm7NphShHnUp6UsUxuJfvpdtiCzcbt3oCyvkonWLFMMjez5BiF8+1LpVhKMHiHIE5HwgVinRUEXNED9L3YK/ywGm014fx85vZO+tPGiYW6Zf9vmu4viqBvd4hTBVIwDCZo1DW92zvITPf83W2kilr0XeyFVvYankyAgzmc03WykA8v6bANb1qeA+5/syt4Ku0Xy27p1DVZEScpk/Mek34Jc9Vls++rNH4r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2uHTGsMyHlxbrdJ3Hhgv0YxmRF9V6gTmaJe9uNYoxU=;
 b=A6VJ4uEXm57uCmXHYmI20D4d0qXo11nZdpH7aM/ChHDnEPIp75no+/wgk8dAmifcApaVzdEfaHi1zWvJh+Xq5nmqPqX3SPjfoKpJfMW5GCXI9vDVY274s+967LJIIhK//c/lwU+J9/RLwAHrd5DLZbSKydnwH/C4UFHn9RmBqKNn3JK6/SnEJlddBdxN8FIc2ZgDihx0WXRLjsde4uuEn20Ap9InzSU6c0tkw1rEN3gKD6W76UBIMTs/0R9BupK1M2YIvivB90voUv3ykIFfY6mF2bmERdw0z7xZow9PSRCPT366ZxgP3oEkN4jvNca5S/Lr5soCGVTW4VrO/LrpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB6242.apcprd04.prod.outlook.com (2603:1096:820:c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 07:11:20 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%9]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 07:11:20 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 1/2] exfat: simplify empty entry hint
Thread-Topic: [PATCH v2 1/2] exfat: simplify empty entry hint
Thread-Index: AdjuiYCKj4IPGKfeSPGqWj6Mqbkdzw==
Date:   Wed, 2 Nov 2022 07:11:20 +0000
Message-ID: <PUZPR04MB6316C6A981A51EA6C079455D81399@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB6242:EE_
x-ms-office365-filtering-correlation-id: 08e83b6e-756b-4af7-88e1-08dabca1718b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64PnOna9/a52xZL2q9YtD+gyhrWM+q8YIEgRH3WEiCjOxrBUCYEaIRReFa1BlkdkxWphj0K2bmpcc8KKjmbKP4Fmz+WOUfJEX9T+By+YhmI4ouEl2Lf4Hchw+5x5VuJnEwq24tZZ2EJ8Z7AW6DA0pl3efwoa+jbonSeYOt62UxVctaidztL4mcfgIkx8+4XDLCc08W49mOsoiaAdzlDleZytdUKGiBrxLvZFoXC1rLqXO5Zrex7uezykXGhVOizYphX/d9mVhDIbLpPhtaoL2lJ2u1+CPrmAhb3CMLbvQkSD8Ioaq/1FQVV1xFp13hyScUDGnb0Y37GMBDFzq+ax+klKasPAMgkpmLDw4PLR3rqQvP0k/FCB4RqxbRwLtNzmZgpEQ2VLfHw3zVt7XqdrVU/RsARbCbT4lz4xtx0FY+FkVHYyfpRD7w8f6W4NZoeC1pZ2eY22lcvX5fFtE1pIAbvmOPmXby2Y1M+ODWRakw/Nj7lOAZoFHRym60UIvRRSu66MXJ6whdpJEXrgaF9Fmy3f2fCoTt9PyT7dLzFlTDTEmZVGPdmeTFRG8hqKWgXOGEgOWqtCOVVUkkfUZdORgYSZijPB7GXmwjH1JdTG3ZvSyMjJnPcXwZSp25RcbcV9TFwv28omFA/TDDAKk2SMVoHIWB0PfL73OlDqAVagidL1RvLVNDx1VfGmctTDm/lwg8RiDIZA/0vjujNKH80OSRjeKm5oSihobgl8QI3CqmUj8RL2hLCX5h1z6ZkAJaqykpVhGZxFpciWqd61lkLTDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199015)(9686003)(6506007)(186003)(107886003)(316002)(26005)(2906002)(83380400001)(7696005)(55016003)(54906003)(66476007)(478600001)(66446008)(41300700001)(5660300002)(64756008)(76116006)(71200400001)(8936002)(66946007)(4326008)(8676002)(66556008)(52536014)(110136005)(86362001)(33656002)(122000001)(82960400001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2VxUXl0Q05sT3BPWXhrNVgrRG9MTm5iUC9MRHl5U2hsbDJPY0JRNFQ1MnZp?=
 =?utf-8?B?ZlJYbTBVbUJNemF4c1RLMVhjSzFhNnBLbVFjemJmc2c4cU56VUN1TlNtODhR?=
 =?utf-8?B?MWE0UkxwejJndXdoWkQyclY5bGhodmtId01ScGxiZnNlYzV1Wk56S2pFeUdS?=
 =?utf-8?B?UnlSNHd6L3VsNUtLTFFKdStwRkNpMnowNSs5K3hTbTBkeUJVSkVxWDVPSEJ0?=
 =?utf-8?B?SVdFUGNaZXpQWkJYNmJPTUQySkhzd3dOQTdUSHlud0xRRHIwM0ZvTkg2Lzg3?=
 =?utf-8?B?aURIV2ZIL01uZ3lGamZjTkc4TnRXWExySUMzWVJKRGRwNnZNaC8wbjIrM1dW?=
 =?utf-8?B?aUE5L2pENXZybHV1NytKdXZGdS95aWE0dSttWUF5Z1lPcVhJV1huTU56RmJi?=
 =?utf-8?B?WVczMjVqaFBNd3Y0eWRhQ3o4ZnRxS1RtOEp3R21GTkY0bmFDRVY2dC8raDhO?=
 =?utf-8?B?WXo3SGpzN1BYRHdzTDBMNWMvZ0hQOUVnbXpsemJXWklMVVVUNVBOSjFsNnp6?=
 =?utf-8?B?R1ZQdG01cElRU2tEanljQzNGcy9KZnZmVElPMGRBZU9HNzlmdXk0eGNLbGpD?=
 =?utf-8?B?Z3loRTdCNjAvNG5HMEN0THZsNFNNVlJ1d0llTnBWZGh0MC9tNThLcURhYTB5?=
 =?utf-8?B?czJjejB3am0reHVHWnpCOFY1ZElmNWtEdnpMRmkwUVdIdGFjWXpsWVhhSjF1?=
 =?utf-8?B?UDMwRGJsRThES2RBZzRRVmgweS95QXZtdFpwQmExdEdaeGRFOGVKT0YrVzFI?=
 =?utf-8?B?VStZWmpNL2kxV2NGWDBLdjNQeEJ2bU1yWElGK01sYmZqZW0wTDlXYUJZV2hw?=
 =?utf-8?B?SlY1N1Q0OEc0bWl0QzlRZXorWGIxaFBxSkNCZGlyQWMyMjFMSFB3NmNCL0tn?=
 =?utf-8?B?K1RpRXZhdTFCVWFBZWg0eWJDNzBOVWV3OHZWelhQa3lCQU5SUkdUSS9SdDRn?=
 =?utf-8?B?NExaK1B3Z0JLeCtaZm9YNVN2L3J6SU9TV0JhTVZnaHRqS0NDR3B6MHQyWGJI?=
 =?utf-8?B?YmxNQnZaMkJCMEJDMGNQdHFyTWhSVXlIeXJVcHAyOXNHSWVSRjYraVlTRFY2?=
 =?utf-8?B?dmhnZFovMHJQbUZZb2tuaTZWV3FQR3NTazdJcjRwa0xQTlpBTUhGZENGUDFy?=
 =?utf-8?B?c1c4OXFOaWI3dE0walFXcXRJUFNBNmxIbE55bjM1MWJtU01rWnNSbUEwQ2dG?=
 =?utf-8?B?QVpEK05yT3N4ek0yeVNLUkthcnlkNUhhY3o1MU1jZTBRdEg2a2JmSWw3ZVBU?=
 =?utf-8?B?VW9Qcjg3bmhLc005cWZxaE54c3VIN20xK0EyRnZyVUNpZzF3c0tJQ3FkTGxq?=
 =?utf-8?B?R3dFYzJMaG1WbmFqQ0Z1ZnFoUFBOS1krUnNVWlc2MHlxTW9meHNueU05N2dQ?=
 =?utf-8?B?Z3RzcUZxVkczVExCSmNyYkNWdGt6QzF2SW85a1dNL3krOVlaNGlScWlMNmFz?=
 =?utf-8?B?a2JZaVNKOXJrenN4aVdtK2h4R0dxNERVMzkrd3JWd3kzMWZ2WUZhVmxpZTlr?=
 =?utf-8?B?aW13R1g0eE14U1NjWEdRNWhTRHFUV01UaHU2K1FGNVVFUDNBOU05dElTd3oz?=
 =?utf-8?B?czBYdXlrYTI1MFFUdmdMUVdueW9OTXR3ZlluVkt5SElDSzVwU0tjbUhWOVdK?=
 =?utf-8?B?d0xXQkZIWURWRlI2M2tjS0FiR1JSei9LaGRHbC9GcWpSamZ5a2dFNFYzN3dK?=
 =?utf-8?B?blJpdEgydldjOHlrak9naUk0MVNuamdOWHNlcFhiUmJNNmZ0Um1BWFQycFpW?=
 =?utf-8?B?MXhqcUw0Q2EweXF0Zy9yN2JsQnR3NHZIclhJWmJORm45eXBYYVgzTXFYRGZ1?=
 =?utf-8?B?YjRFVzYxN01Ra21XYlNkb1I2Mmxabm1GcjQ5cFh4emd5QllzRTJFc1hQZjZB?=
 =?utf-8?B?bERDMnZCNUhSWmJYSkhYOHV3S0FSU2VsQklOWXMvS0gwTTBCdDlwWnYwZWs5?=
 =?utf-8?B?TG80dFE2aUVxc0NRbTB1ZnFmbXkzMVZXVFEyWlBzdW04NENYUnlkK081TCs0?=
 =?utf-8?B?TmpmdklTbnpOcE5nNWd6bnM3RG4yMU1LUW83SXdNKzNSUzZzNk1HSGNsZzQ2?=
 =?utf-8?B?RGVGeWNlT2lpZi9OTldCY2ZycFNmY3lXSXFIb3pCWCsvMkt4VCt3OU5Cam1H?=
 =?utf-8?Q?DDRM7Hp6bkeNVwk7XwrOOKauw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e83b6e-756b-4af7-88e1-08dabca1718b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 07:11:20.6760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRA4Z5DmuCmQ+Zncaml4q2wtDu8op7DpypGciCXaixDF8YLD6nSZEueUBAuoq0xXU2LPosCB7sbnCClgENiUQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB6242
X-Proofpoint-ORIG-GUID: MGnxl7cr5Hs9xEG4IJl2V5VMcN96zIPl
X-Proofpoint-GUID: MGnxl7cr5Hs9xEG4IJl2V5VMcN96zIPl
X-Sony-Outbound-GUID: MGnxl7cr5Hs9xEG4IJl2V5VMcN96zIPl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_04,2022-11-01_02,2022-06-22_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBleGZhdF9zZXRfZW1wdHlfaGludCgpL2V4ZmF0X3Jlc2V0X2VtcHR5
X2hpbnQoKQ0KdG8gcmVkdWNlIGNvZGUgY29tcGxleGl0eSBhbmQgbWFrZSBjb2RlIG1vcmUgcmVh
ZGFibGUuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNv
bT4NClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFveWFtYSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9k
aXIuYyB8IDU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZGlyLmMgYi9mcy9leGZhdC9kaXIuYw0KaW5kZXggYTI3
YjU1ZWMwNjBhLi45ZjliODQzNWJhY2EgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9kaXIuYw0KKysr
IGIvZnMvZXhmYXQvZGlyLmMNCkBAIC04OTcsNiArODk3LDI5IEBAIHN0cnVjdCBleGZhdF9lbnRy
eV9zZXRfY2FjaGUgKmV4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
DQogCXJldHVybiBOVUxMOw0KIH0NCiANCitzdGF0aWMgaW5saW5lIHZvaWQgZXhmYXRfcmVzZXRf
ZW1wdHlfaGludChzdHJ1Y3QgZXhmYXRfaGludF9mZW1wICpoaW50X2ZlbXApDQorew0KKwloaW50
X2ZlbXAtPmVpZHggPSBFWEZBVF9ISU5UX05PTkU7DQorCWhpbnRfZmVtcC0+Y291bnQgPSAwOw0K
K30NCisNCitzdGF0aWMgaW5saW5lIHZvaWQgZXhmYXRfc2V0X2VtcHR5X2hpbnQoc3RydWN0IGV4
ZmF0X2lub2RlX2luZm8gKmVpLA0KKwkJc3RydWN0IGV4ZmF0X2hpbnRfZmVtcCAqY2FuZGlfZW1w
dHksIHN0cnVjdCBleGZhdF9jaGFpbiAqY2x1LA0KKwkJaW50IGRlbnRyeSwgaW50IG51bV9lbnRy
aWVzKQ0KK3sNCisJaWYgKGVpLT5oaW50X2ZlbXAuZWlkeCA9PSBFWEZBVF9ISU5UX05PTkUgfHwN
CisJICAgIGVpLT5oaW50X2ZlbXAuZWlkeCA+IGRlbnRyeSkgew0KKwkJaWYgKGNhbmRpX2VtcHR5
LT5jb3VudCA9PSAwKSB7DQorCQkJY2FuZGlfZW1wdHktPmN1ciA9ICpjbHU7DQorCQkJY2FuZGlf
ZW1wdHktPmVpZHggPSBkZW50cnk7DQorCQl9DQorDQorCQljYW5kaV9lbXB0eS0+Y291bnQrKzsN
CisJCWlmIChjYW5kaV9lbXB0eS0+Y291bnQgPT0gbnVtX2VudHJpZXMpDQorCQkJZWktPmhpbnRf
ZmVtcCA9ICpjYW5kaV9lbXB0eTsNCisJfQ0KK30NCisNCiBlbnVtIHsNCiAJRElSRU5UX1NURVBf
RklMRSwNCiAJRElSRU5UX1NURVBfU1RSTSwNCkBAIC05MjEsNyArOTQ0LDcgQEAgaW50IGV4ZmF0
X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9pbm9k
ZV9pbmZvICplaSwNCiB7DQogCWludCBpLCByZXdpbmQgPSAwLCBkZW50cnkgPSAwLCBlbmRfZWlk
eCA9IDAsIG51bV9leHQgPSAwLCBsZW47DQogCWludCBvcmRlciwgc3RlcCwgbmFtZV9sZW4gPSAw
Ow0KLQlpbnQgZGVudHJpZXNfcGVyX2NsdSwgbnVtX2VtcHR5ID0gMDsNCisJaW50IGRlbnRyaWVz
X3Blcl9jbHU7DQogCXVuc2lnbmVkIGludCBlbnRyeV90eXBlOw0KIAl1bnNpZ25lZCBzaG9ydCAq
dW5pbmFtZSA9IE5VTEw7DQogCXN0cnVjdCBleGZhdF9jaGFpbiBjbHU7DQpAQCAtOTM5LDEwICs5
NjIsMTMgQEAgaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJCWVuZF9laWR4ID0gZGVudHJ5Ow0KIAl9
DQogDQotCWNhbmRpX2VtcHR5LmVpZHggPSBFWEZBVF9ISU5UX05PTkU7DQorCWV4ZmF0X3Jlc2V0
X2VtcHR5X2hpbnQoJmVpLT5oaW50X2ZlbXApOw0KKw0KIHJld2luZDoNCiAJb3JkZXIgPSAwOw0K
IAlzdGVwID0gRElSRU5UX1NURVBfRklMRTsNCisJZXhmYXRfcmVzZXRfZW1wdHlfaGludCgmY2Fu
ZGlfZW1wdHkpOw0KKw0KIAl3aGlsZSAoY2x1LmRpciAhPSBFWEZBVF9FT0ZfQ0xVU1RFUikgew0K
IAkJaSA9IGRlbnRyeSAmIChkZW50cmllc19wZXJfY2x1IC0gMSk7DQogCQlmb3IgKDsgaSA8IGRl
bnRyaWVzX3Blcl9jbHU7IGkrKywgZGVudHJ5KyspIHsNCkBAIC05NjIsMjYgKzk4OCw4IEBAIGlu
dCBleGZhdF9maW5kX2Rpcl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZXhm
YXRfaW5vZGVfaW5mbyAqZWksDQogCQkJICAgIGVudHJ5X3R5cGUgPT0gVFlQRV9ERUxFVEVEKSB7
DQogCQkJCXN0ZXAgPSBESVJFTlRfU1RFUF9GSUxFOw0KIA0KLQkJCQludW1fZW1wdHkrKzsNCi0J
CQkJaWYgKGNhbmRpX2VtcHR5LmVpZHggPT0gRVhGQVRfSElOVF9OT05FICYmDQotCQkJCQkJbnVt
X2VtcHR5ID09IDEpIHsNCi0JCQkJCWV4ZmF0X2NoYWluX3NldCgmY2FuZGlfZW1wdHkuY3VyLA0K
LQkJCQkJCWNsdS5kaXIsIGNsdS5zaXplLCBjbHUuZmxhZ3MpOw0KLQkJCQl9DQotDQotCQkJCWlm
IChjYW5kaV9lbXB0eS5laWR4ID09IEVYRkFUX0hJTlRfTk9ORSAmJg0KLQkJCQkJCW51bV9lbXB0
eSA+PSBudW1fZW50cmllcykgew0KLQkJCQkJY2FuZGlfZW1wdHkuZWlkeCA9DQotCQkJCQkJZGVu
dHJ5IC0gKG51bV9lbXB0eSAtIDEpOw0KLQkJCQkJV0FSTl9PTihjYW5kaV9lbXB0eS5laWR4IDwg
MCk7DQotCQkJCQljYW5kaV9lbXB0eS5jb3VudCA9IG51bV9lbXB0eTsNCi0NCi0JCQkJCWlmIChl
aS0+aGludF9mZW1wLmVpZHggPT0NCi0JCQkJCQkJRVhGQVRfSElOVF9OT05FIHx8DQotCQkJCQkJ
Y2FuZGlfZW1wdHkuZWlkeCA8PQ0KLQkJCQkJCQkgZWktPmhpbnRfZmVtcC5laWR4KQ0KLQkJCQkJ
CWVpLT5oaW50X2ZlbXAgPSBjYW5kaV9lbXB0eTsNCi0JCQkJfQ0KKwkJCQlleGZhdF9zZXRfZW1w
dHlfaGludChlaSwgJmNhbmRpX2VtcHR5LCAmY2x1LA0KKwkJCQkJCWRlbnRyeSwgbnVtX2VudHJp
ZXMpOw0KIA0KIAkJCQlicmVsc2UoYmgpOw0KIAkJCQlpZiAoZW50cnlfdHlwZSA9PSBUWVBFX1VO
VVNFRCkNCkBAIC05ODksOCArOTk3LDcgQEAgaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJCQkJY29u
dGludWU7DQogCQkJfQ0KIA0KLQkJCW51bV9lbXB0eSA9IDA7DQotCQkJY2FuZGlfZW1wdHkuZWlk
eCA9IEVYRkFUX0hJTlRfTk9ORTsNCisJCQlleGZhdF9yZXNldF9lbXB0eV9oaW50KCZjYW5kaV9l
bXB0eSk7DQogDQogCQkJaWYgKGVudHJ5X3R5cGUgPT0gVFlQRV9GSUxFIHx8IGVudHJ5X3R5cGUg
PT0gVFlQRV9ESVIpIHsNCiAJCQkJc3RlcCA9IERJUkVOVF9TVEVQX0ZJTEU7DQpAQCAtMTA5MCw5
ICsxMDk3LDYgQEAgaW50IGV4ZmF0X2ZpbmRfZGlyX2VudHJ5KHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IsIHN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICplaSwNCiAJCXJld2luZCA9IDE7DQogCQlkZW50
cnkgPSAwOw0KIAkJY2x1LmRpciA9IHBfZGlyLT5kaXI7DQotCQkvKiByZXNldCBlbXB0eSBoaW50
ICovDQotCQludW1fZW1wdHkgPSAwOw0KLQkJY2FuZGlfZW1wdHkuZWlkeCA9IEVYRkFUX0hJTlRf
Tk9ORTsNCiAJCWdvdG8gcmV3aW5kOw0KIAl9DQogDQotLSANCjIuMjUuMQ0K
