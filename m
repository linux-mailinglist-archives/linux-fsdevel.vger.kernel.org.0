Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4434AD278
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 08:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346663AbiBHHqL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 02:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbiBHHqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 02:46:10 -0500
X-Greylist: delayed 3685 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 23:46:09 PST
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BD7C0401EF;
        Mon,  7 Feb 2022 23:46:08 -0800 (PST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2182P4Z3009858;
        Tue, 8 Feb 2022 06:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=rb6ia/LezbSUpCOQjr8GtT9nOMLyHQWrHK8DTE1rJnU=;
 b=HRI+dJ4bvlJZdjFV17AumUgyRocF/8/TwiLYrHHDrlHEgkqawMmyJAYTrWsNa+lA8vAt
 X3zMcbrAftSdCDboUPhfGKMnpeG8XOoAezOO1t3IU/PvAoU7wK0p2s0x5mCBrZiAsPLJ
 vLi/lepKwD8JWrcFVMGEUNDBPpSIhN7cG8x7XN9iVQfqgK+uXX7PfRskLrWu/Wk81fFa
 ehq5hHMECIBMYdmFwNz3Ar7fhYZmDtgoK16tFpYukItKCcPp0NtTX5JOeF4hKuPHcC63
 1TF9hnTXolcGhdSX13tGwrrIVQW27hj7Rua9ZI+0Kg6jF64xxD9Wuhimtua4JPOxL6d2 5Q== 
Received: from apc01-hk2-obe.outbound.protection.outlook.com (mail-hk2apc01lp2053.outbound.protection.outlook.com [104.47.124.53])
        by mx08-001d1705.pphosted.com with ESMTP id 3e1ed5jju9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 06:44:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAi+nn76QHsZozdUNQGQV/lJNmCVnOtTKkmmki+B+Padmo2E+jEJvqkeF6oqGgYNQH89eijka8GlC5Wf7d/hRsyR1znC8SgNq+GuAAelhiUTNO/qXsOTbhz6a1KevzGNbb6SQkPI9vb5Mj5faFv7Qe8VO+MJthMwUISOIH5Ke2Wg+lPgCJzNqiJMdWXHlPviRh0JKNHGXXSalxIxB/JDSrMg0GB2Ud4Hbr9pToAtODVDEnYH6r1V5jjg9iq7LfDjDDLB1cByt+bcQ11fNWXgtUMsZenEWYtJxFVlAdjt9ZUC6MQO5tB8QKh0FfMK64WtLgsohQsuJkjrCnRi4XJz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb6ia/LezbSUpCOQjr8GtT9nOMLyHQWrHK8DTE1rJnU=;
 b=eJao7w1pAag4L2kFTrsCtpRnKkZ/gK6iKTWOPZnP7MOeuXEUSs2qskrGziUQauzqL3QUdu4t07j+TZds5Zcy4ANzaN6naXsL+RTM6Oa4lg9swTd+gWr4LA4TqzxsKCE/1uje96B4N9jVY9Fpd87oQ5+utGSxe4cKwxR4Aqr24y4c/qKTOnaF/set4W2NR4l6r8XLCTZc3gypOfrdwLnBFnP3cDSDOmut05Pw5fsS7JrPLIstS/m/BM333X/T+WCwLTb2VuwwbGhygSNjfi/ovMNJCxE3PsdKD4hGylyK/MusuBFnNZtaCYNOVrjWG5XoyodMJ3iJLQx0A1loCBlAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by PS2PR04MB3736.apcprd04.prod.outlook.com (2603:1096:300:67::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 06:43:24 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::24c5:f243:ecdd:80b7]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::24c5:f243:ecdd:80b7%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 06:43:24 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Index: AQHYHKozeVmted1T5UKvjQCq+AaGCayJLtGw
Date:   Tue, 8 Feb 2022 06:43:23 +0000
Message-ID: <HK2PR04MB3891BFAB9DD271F5330D37A1812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 259bd9d2-d83d-4181-f1b2-08d9eace4ddd
x-ms-traffictypediagnostic: PS2PR04MB3736:EE_
x-microsoft-antispam-prvs: <PS2PR04MB37360959A2EDC732BB2C570F812D9@PS2PR04MB3736.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:36;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: icfJuXcFK9jushsqtAsDA0RpJ1D4ZenNXYloT/wwoMoJIy99U5eV8ok01tZCrGcwGb2WwXhKZEhpBBV5qWJpzfYoxA9UWddWAZ3N97gx6qrXOiKa5XR0w5EOJUq2uFo3vunZoPtjBJhMTquFU7o5OSZ1fASgcRUlRoH7w5i46KoSa3mM95EOL5jfWJHl6iumsZcped/D7BkrDcf9D+qKziDvHPDmKhBr1grrXl5th3LDDullU1/zqLgTaYy9ymIni5yUiyPUBBpplf+TgY1Su+7NVrkiqlArLZNJEVfgRth8y9zVtotwi8di3vXP/1zUbvd383uk6qTSN0CBXxOe6+DZSfkRuA1F+pHGeMvWrcqBXc+4g6lF+30B3mFmkvh/nEwpu3vOf6C2AioHCW9JzTkT6wQV3WQJBceiSJFphdhyfrjlqeW1sytVmFb7vCkGcGSJ8tby9563uyYcXXp+tOvoiB+kB+I8kUm/axjxFlDKjFhnSXrDiQIeJGsfn3WQEs3Zwk8hpaFLXmgBm+gY5F/DvivA6bJxi4Q+ID4lOPEUNrj5xBdJ27AoNp6ZXO9BMUkwn/HqG/C0B2N+d0O/APl/E6SoZBfVXFQ6n8d9F9quEQC+ZvttlxkBLDEz6phqizOp+ixGXsixcnKEttETOsb/i86CxeXxLj3pEb32JZGaSOo8GcVnm0nESUM6ESFJtUCfbLH5AbhcW2Thb77aTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2940100002)(86362001)(9686003)(6506007)(7696005)(66556008)(8676002)(66446008)(66476007)(52536014)(55016003)(64756008)(4326008)(8936002)(83380400001)(53546011)(66946007)(54906003)(5660300002)(316002)(33656002)(38070700005)(71200400001)(76116006)(122000001)(82960400001)(26005)(110136005)(186003)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjZnU05FTUxQRTJHa3l6ampZb1k0cmJSK09HS1RrcFNYcExxTDJBSE9vUi9W?=
 =?utf-8?B?TjJBZDFIQ3VPOGlGODI5YzdsZ3h0b2ZodEFSZ09JNENVN1hlblpkOTRSM0RP?=
 =?utf-8?B?RnBsaHpKN1o3MlN2UzVRZlYzMVJHZU13MXMyZ0htTHk4RHkxTWN2aEw1M1NE?=
 =?utf-8?B?aEF3QThreHF2bitWcVhvLzk0NHJBZmZKeEt1UnJ3dnI2d3RTb1FKK1FMTFEy?=
 =?utf-8?B?dmh5YlY3d05lM1dITklPblZvVFlnVnRNNlo4WnZ3RTlIS1J5NWtsYlJsTjQx?=
 =?utf-8?B?UHQzVitKR2NFbmM0WUlXZUF5VEQrYTBEWWFpL29Gb3JFYzQ0bU40cktYTERo?=
 =?utf-8?B?ZCtNZVU0RGIyVWlhd1dscjMxNUYzcGNhZUI3THlWU0RMUE1YazJXSHEzZndv?=
 =?utf-8?B?Y1NEMnRUN0ZJSjNiSW80djhJaUl2UkZlRkVNK0NUNUVLalZtMG9MaUxFbEMv?=
 =?utf-8?B?eDZxTnpxaWdtV3lvbkMyUmhnQ1Q3OStvR2NFU1BBRHFBajZmNnpiTmNCc1FE?=
 =?utf-8?B?R2NGTDhSbThRa1g5OC9zU3RjRE9jWHYwemUrK3JoZjBIWU5XMDlJVlQ2Rkt6?=
 =?utf-8?B?ZDRaeHgvY2VmU1E3azI4NHB3ejllbElvWjNJRllzMjMySyt4WnF5cXRNYTZn?=
 =?utf-8?B?OFFOMTNvWk1Xa05OVXl0R2d6c3Z3b3ZHaGxIYlpHQ056N2pMaHBnVm1kVVNC?=
 =?utf-8?B?VGVxbWxqNHhJRDJEK0w2WWk5SmVSbHhWV25SN1JNQmQ0cEd1OWhOWG0zSU85?=
 =?utf-8?B?S01GdUo3QnRXNUNJT2Vua2cxZlYzT3FqZnVma1dHQ0JXdjg4WVVpODA3TGE5?=
 =?utf-8?B?YzBuQlYwUENjNVUzZUZuMjZmaUl4YWlIWVZBTlQyRlRnanB2Mml2SGZsZzR0?=
 =?utf-8?B?VUxNbU56VlJHSzVyc1hNeXJGSisxZVg3VURzVlVhMGxQYnhxakk1Vk12UmJa?=
 =?utf-8?B?Q1puR2xhNEZYSEdxMU5lTlJEWFN6MGJOTUorazlZQWViQlVvRDEwa1ZlOEVv?=
 =?utf-8?B?YlBZaHdqZXJZSW1NZlVsWDZueVM2MEIxK2VVdG5EQ1pYZ1FsTlE1RXpqcnBE?=
 =?utf-8?B?MEVjZjNhWUhEU3hoVkg4aEpXelpscndVbjA3b1NNNWQ2NGhXbTE5NlJHLzNY?=
 =?utf-8?B?WlY2VXJCWW5YSXRGZU1nOHdGQ05DNUtSY3lOT0NXR2o2Sm1EaWZzMkZYbVZY?=
 =?utf-8?B?U091UGNTOU9xN2Q5QU9CVFdyaUdsRDQzZlAvUko1RFRPN25QTXhacnVLajEz?=
 =?utf-8?B?Njk3SUcrYmZLNWRvWjBsQUJ2dEo5eiswRWlNWFQ4U25ENU9yT0Uyc0YvWmxE?=
 =?utf-8?B?a002YnhFVTBITTlXWXNBcjlPaFpRNXpWeWhkMXhMUURBT1o0Wk90SE8yMFlW?=
 =?utf-8?B?QVN4NEwvVyt0Ymt5a2FrYmlmcUFyUnh0UWZjUTQxTG5Qa2ZzaXpUM0hveld5?=
 =?utf-8?B?K3hDRjQwZHU0SjFPWmJyVm1KT0gzUFE5NmdHZ1phN2FrSHVTbjArd2RRYVVx?=
 =?utf-8?B?MTcweE5RaWtPZm9ucS81R3J5bllyMHM0bEx2ZU81WTMycDdZMGMzd0w5cWEx?=
 =?utf-8?B?a1d1U1l0ZDlaMzNyU1RpSVFXaXlyNU1mVlFQQnB4UnZMdmFLNFROSmhrc0pE?=
 =?utf-8?B?M3d5YVdBcWlmK29CL2JaelVqSVVDb2ViT1BHSk54RGF5NGdJVDQyS2UyZHlE?=
 =?utf-8?B?ZmhQeDZnS0QyemRTWWFtZzI3M3ZJTm1YQ0ZSL3dTUk1RVEpXWkFhNGhLNHds?=
 =?utf-8?B?STk5TVIrS2RPbzBhdmRBQ2JHempWTjlMYmU0OVhWOEZrNTdSVDhEWXF3OVdD?=
 =?utf-8?B?MitEV1ZJa0tEak56bFVSV3J3cHEzRDZGNUI3TkhqeHNpWHJ5UkxlQlQrRVZr?=
 =?utf-8?B?R3g1WWVHZ0RHQWlIZGRGbkhrZ1BQa1l2WWMxa0pUb0NwZmo3SWgzUzVsdFR1?=
 =?utf-8?B?ZDFTQU9mSkZXS0JMYkhnS3F5bzlML3BVV0s2MHJGUU9vS0ttYStBc2VoNStq?=
 =?utf-8?B?NEc5NWVSL2hiYUpoSmcyTWhjTVg4NE1WaTRMMk5xdnBtZjEvVUlUaUlxeDkz?=
 =?utf-8?B?TFdxRDFYamU3YVppNVl1dUVIaWhKOWtEckQ4cjA0Y3A3MWMzTTRQS1B4Tk9J?=
 =?utf-8?B?bHpjeUdnclNUazhoZ21xMXZkUjdXSkQyNXlKa0ZSaysyOXpnNTN1VzJEcXps?=
 =?utf-8?Q?j4K/+QRXOCK6kWbnwn1fcQA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259bd9d2-d83d-4181-f1b2-08d9eace4ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 06:43:23.9408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/xTTEYuRAgOmKLaxUInqNpUon95Ff3CQB3nVZK8M9G7Q5nKCdKH4HinYFSh1wsT00PlsdvdUh7nT9I6MXaW9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR04MB3736
X-Proofpoint-GUID: HMKwnG6GCUs7J6FGXRXJxj-X7RC6JrVv
X-Proofpoint-ORIG-GUID: HMKwnG6GCUs7J6FGXRXJxj-X7RC6JrVv
X-Sony-Outbound-GUID: HMKwnG6GCUs7J6FGXRXJxj-X7RC6JrVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_02,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbSB0aGUgZXhGQVQgc3BlYywgVm9sdW1lRGlydHkgc2hvdWxkIGJlIGNsZWFyZWQgYWZ0ZXIg
dXBkYXRpbmcgdGhlIGRpcmVjdG9yeSBlbnRyeS4NCg0KMS4gU2V0IHRoZSB2YWx1ZSBvZiB0aGUg
Vm9sdW1lRGlydHkgZmllbGQgdG8gMQ0KMi4gVXBkYXRlIHRoZSBhY3RpdmUgRkFULCBpZiBuZWNl
c3NhcnkNCjMuIFVwZGF0ZSB0aGUgYWN0aXZlIEFsbG9jYXRpb24gQml0bWFwDQo0LiBDcmVhdGUg
b3IgdXBkYXRlIHRoZSBkaXJlY3RvcnkgZW50cnksIGlmIG5lY2Vzc2FyeQ0KNS4gQ2xlYXIgdGhl
IHZhbHVlIG9mIHRoZSBWb2x1bWVEaXJ0eSBmaWVsZCB0byAwLCBpZiBpdHMgdmFsdWUgcHJpb3Ig
dG8gdGhlIGZpcnN0IHN0ZXAgd2FzIDANCg0KQnV0IFZvbHVtZURpcnR5IHdpbGwgYmUgY2xlYXJl
ZCBmaXJzdCBpbiB3cml0ZWJhY2sgaWYgJ2RpcnN5bmMnIG9yICdzeW5jJyBpcyBub3QgZW5hYmxl
ZC4NClJlZmVyIHRoZSBibGt0cmFjZSBsb2cgb2YgJ21rZGlyIC9tbnQvdGVzdC9kaXIxJyBhcyBh
biBleGFtcGxlLg0KDQoxNzksMyAgICAwICAgICAgICAxICAgICAwLjAwMDAwMDAwMCAgICAxMCAg
QyAgV1MgMjYyMzQ4OCArIDEgWzBdICAgICAgICAgPD0gU2V0IFZvbHVtZURpcnR5DQoxNzksMyAg
ICAzICAgICAgICAxICAgICA1LjA1MjI2MjAwMSAgICAyNiAgQyAgIFcgMjYyMzQ4OCArIDEgWzBd
ICAgICAgICAgPD0gQ2xlYXIgVm9sdW1lRGlydHkNCjE3OSwzICAgIDMgICAgICAgIDIgICAgIDUu
MDU0Njg1NjY3ICAgIDI2ICBDICAgVyAyNjI3NTg0ICsgMSBbMF0gICAgICAgICA8PSBCaXRtYXAN
CjE3OSwzICAgIDMgICAgICAgIDMgICAgIDUuMDU2Nzk1NjY3ICAgIDI2ICBDICAgVyAyNjI4MzUy
ICsgMSBbMF0gICAgICAgICA8PSBCb2R5IGRhdGEgb2YgL3Rlc3QvDQoxNzksMyAgICAzICAgICAg
ICA0ICAgICA1LjA2Njc5MDAwMSAgICAyNiAgQyAgIFcgMjYyODYwOCArIDEyOCBbMF0gICAgICAg
PD0gQm9keSBkYXRhIG9mIC90ZXN0L2RpcjEvDQoxNzksMyAgICAzICAgICAgICA1ICAgICA1LjA3
NTk5ODY2NyAgICAyNiAgQyAgIFcgMjYyODczNiArIDEyOCBbMF0gICAgICAgPD0gQm9keSBkYXRh
IG9mIC90ZXN0L2RpcjEvDQoxNzksMyAgICAzICAgICAgICA2ICAgICA1LjA3ODQwOTMzNCAgICAg
MCAgQyAgV1MgMjYyMzQ4OCArIDEgWzBdICAgICAgICAgPD0gU2V0IFZvbHVtZURpcnR5DQoxNzks
MyAgICAzICAgICAgICA3ICAgIDIwLjIzOTQ4NjAwMiAgICAgMCAgQyAgIFcgMjYyODA5NiArIDEg
WzBdICAgICAgICAgPD0gQm9keSBkYXRhIG9mIC8NCg0KQWZ0ZXIgYXBwbHlpbmcgdGhpcyBwYXRj
aCwgVm9sdW1lRGlydHkgd2lsbCBub3QgYmUgY2xlYXJlZCB1bnRpbCAnc3luYycgb3IgJ3Vtb3Vu
dCcgaXMgcGVyZm9ybWVkLg0KDQoxNzksMyAgICAyICAgICAgICAxICAgICAwLjAwMDAwMDAwMCAg
ICAgMCAgQyAgV1MgMjYyMzQ4OCArIDEgWzBdICAgICAgICAgPD0gU2V0IFZvbHVtZURpcnR5DQox
NzksMyAgICAwICAgICAgICAxICAgIDMwLjIyMTQ3NTY3MCAgICAgOSAgQyAgIFcgMjYyNzU4NCAr
IDEgWzBdICAgICAgICAgPD0gQml0bWFwDQoxNzksMyAgICAwICAgICAgICAyICAgIDMwLjIyMzc5
NDMzNyAgICAgOSAgQyAgIFcgMjYyODM1MiArIDEgWzBdICAgICAgICAgPD0gQm9keSBkYXRhIG9m
IC90ZXN0Lw0KMTc5LDMgICAgMCAgICAgICAgMyAgICAzMC4yMzMxNjQwMDMgICAgIDkgIEMgICBX
IDI2MjkzNzYgKyAxMjggWzBdICAgICAgIDw9IEJvZHkgZGF0YSBvZiAvdGVzdC9kaXIxLw0KMTc5
LDMgICAgMCAgICAgICAgNCAgICAzMC4yNDI0NDk2NzAgICAgIDkgIEMgICBXIDI2Mjk1MDQgKyAx
MjggWzBdICAgICAgIDw9IEJvZHkgZGF0YSBvZiAvdGVzdC9kaXIxLw0KMTc5LDMgICAgMCAgICAg
ICAgNSAgICA2MC40NDU5ODUwMDcgICAgIDkgIEMgICBXIDI2MjgwOTYgKyAxIFswXSAgICAgICAg
IDw9IEJvZHkgZGF0YSBvZiAvDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IE1vLCBZdWV6aGFuZyANClNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDgsIDIwMjIgMToxOSBQTQ0K
VG86IGxpbmtpbmplb25Aa2VybmVsLm9yZzsgc2oxNTU3LnNlb0BzYW1zdW5nLmNvbQ0KQ2M6IGxp
bnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQpTdWJqZWN0OiBbUEFUQ0hdIGV4ZmF0OiBkbyBub3QgY2xlYXIgVm9sdW1lRGlydHkgaW4gd3Jp
dGViYWNrDQoNCkJlZm9yZSB0aGlzIGNvbW1pdCwgVm9sdW1lRGlydHkgd2lsbCBiZSBjbGVhcmVk
IGZpcnN0IGluIHdyaXRlYmFjayBpZiAnZGlyc3luYycgb3IgJ3N5bmMnIGlzIG5vdCBlbmFibGVk
LiBJZiB0aGUgcG93ZXIgaXMgc3VkZGVubHkgY3V0IG9mZiBhZnRlciBjbGVhbmluZyBWb2x1bWVE
aXJ0eSBidXQgb3RoZXIgdXBkYXRlcyBhcmUgbm90IHdyaXR0ZW4sIHRoZSBleEZBVCBmaWxlc3lz
dGVtIHdpbGwgbm90IGJlIGFibGUgdG8gZGV0ZWN0IHRoZSBwb3dlciBmYWlsdXJlIGluIHRoZSBu
ZXh0IG1vdW50Lg0KDQpBbmQgVm9sdW1lRGlydHkgd2lsbCBiZSBzZXQgYWdhaW4gd2hlbiB1cGRh
dGluZyB0aGUgcGFyZW50IGRpcmVjdG9yeS4gSXQgbWVhbnMgdGhhdCBCb290U2VjdG9yIHdpbGwg
YmUgd3JpdHRlbiB0d2ljZSBpbiBlYWNoIHdyaXRlYmFjaywgdGhhdCB3aWxsIHNob3J0ZW4gdGhl
IGxpZmUgb2YgdGhlIGRldmljZS4NCg0KUmV2aWV3ZWQtYnk6IEFuZHkuV3UgPEFuZHkuV3VAc29u
eS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hLCBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5j
b20+DQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZy5NbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQot
LS0NCiBmcy9leGZhdC9zdXBlci5jIHwgMTQgKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4
ZmF0L3N1cGVyLmMgYi9mcy9leGZhdC9zdXBlci5jIGluZGV4IDhjOWZiN2RjZWMxNi4uZjQ5MDZj
MTc0NzVlIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvc3VwZXIuYw0KKysrIGIvZnMvZXhmYXQvc3Vw
ZXIuYw0KQEAgLTI1LDYgKzI1LDggQEANCiBzdGF0aWMgY2hhciBleGZhdF9kZWZhdWx0X2lvY2hh
cnNldFtdID0gQ09ORklHX0VYRkFUX0RFRkFVTFRfSU9DSEFSU0VUOyAgc3RhdGljIHN0cnVjdCBr
bWVtX2NhY2hlICpleGZhdF9pbm9kZV9jYWNoZXA7DQogDQorc3RhdGljIGludCBfX2V4ZmF0X2Ns
ZWFyX3ZvbHVtZV9kaXJ0eShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKTsNCisNCiBzdGF0aWMgdm9p
ZCBleGZhdF9mcmVlX2lvY2hhcnNldChzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpKSAgew0KIAlp
ZiAoc2JpLT5vcHRpb25zLmlvY2hhcnNldCAhPSBleGZhdF9kZWZhdWx0X2lvY2hhcnNldCkgQEAg
LTY0LDcgKzY2LDcgQEAgc3RhdGljIGludCBleGZhdF9zeW5jX2ZzKHN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IsIGludCB3YWl0KQ0KIAkvKiBJZiB0aGVyZSBhcmUgc29tZSBkaXJ0eSBidWZmZXJzIGlu
IHRoZSBiZGV2IGlub2RlICovDQogCW11dGV4X2xvY2soJnNiaS0+c19sb2NrKTsNCiAJc3luY19i
bG9ja2RldihzYi0+c19iZGV2KTsNCi0JaWYgKGV4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYikp
DQorCWlmIChfX2V4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzYikpDQogCQllcnIgPSAtRUlPOw0K
IAltdXRleF91bmxvY2soJnNiaS0+c19sb2NrKTsNCiAJcmV0dXJuIGVycjsNCkBAIC0xMzksMTMg
KzE0MSwyMSBAQCBpbnQgZXhmYXRfc2V0X3ZvbHVtZV9kaXJ0eShzdHJ1Y3Qgc3VwZXJfYmxvY2sg
KnNiKQ0KIAlyZXR1cm4gZXhmYXRfc2V0X3ZvbF9mbGFncyhzYiwgc2JpLT52b2xfZmxhZ3MgfCBW
T0xVTUVfRElSVFkpOyAgfQ0KIA0KLWludCBleGZhdF9jbGVhcl92b2x1bWVfZGlydHkoc3RydWN0
IHN1cGVyX2Jsb2NrICpzYikNCitzdGF0aWMgaW50IF9fZXhmYXRfY2xlYXJfdm9sdW1lX2RpcnR5
KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpDQogew0KIAlzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2Jp
ID0gRVhGQVRfU0Ioc2IpOw0KIA0KIAlyZXR1cm4gZXhmYXRfc2V0X3ZvbF9mbGFncyhzYiwgc2Jp
LT52b2xfZmxhZ3MgJiB+Vk9MVU1FX0RJUlRZKTsgIH0NCiANCitpbnQgZXhmYXRfY2xlYXJfdm9s
dW1lX2RpcnR5KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpIHsNCisJaWYgKHNiLT5zX2ZsYWdzICYg
KFNCX1NZTkNIUk9OT1VTIHwgU0JfRElSU1lOQykpDQorCQlyZXR1cm4gX19leGZhdF9jbGVhcl92
b2x1bWVfZGlydHkoc2IpOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGludCBleGZh
dF9zaG93X29wdGlvbnMoc3RydWN0IHNlcV9maWxlICptLCBzdHJ1Y3QgZGVudHJ5ICpyb290KSAg
ew0KIAlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiID0gcm9vdC0+ZF9zYjsNCi0tDQoyLjI1LjENCg==
