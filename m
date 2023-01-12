Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE1C66699E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 04:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjALD3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 22:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjALD3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 22:29:20 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAA0F58C
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 19:29:18 -0800 (PST)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BMhOIj002301;
        Thu, 12 Jan 2023 03:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=m5QJX17hQj7CiWBNvHTLgpAoUUGQB9oqL8XZJCWyAHE=;
 b=aYmabGJmWTJB/dVxGbycCv4GabU5I6wMHW74QQ7/Q4G0U0r+tVNmgYCKN2oHX7Tmu0J8
 5WHv/0QFVo38NVPVhBR0Qtg5oHfErLLdRhATlp0+zOgo9EvouMjrYC8rvKyqJh8omaOY
 /zGBXq9QbHfQ/z1MiLWwJQm9M32ozWHJMjeS7t9BPDtxa6DlRPGOHQowzMXUKnmL8+m4
 1jAQ76BHYTAf93qlsIPRNI8XQMe7iAFTmtRStzuGeOHXOOIWnITZcDtlGkl9/UZ3qjWc
 VRX5SYWIPzhbpXNlKNu2w0Wp4H+4JIL2NX3qTZ7W3bCnd3DflKPueA57XQz/lM545q2x Cw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3n1m1s18qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 03:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjM0efmrrPXY+wAKX+OwOlJfVVOsVRYfnd16Ym7gx6MMBReZzkVISUGrGdviwMZQqR6zpTatdIynl6y48vc78pWZdGQqjpq8LKsI2ft/7qo0uOg/UuAhtmOg3Hsaqyi5O2sMMqwf1vczK5pIHAPkRbRgF553WFRwjCykwKFgQ0jXODDyhPWD1NrK8TaQilYn7o85HzZ5TIku+oBbQ6yJTiojYbg9SdkgkNQ44fHt87AzqdTs71lbX0Z40uX3P3oA96Dxy8M45Nk3pVaffGWVxIlcjV75DrAQQmTghJY5N39Ltrtg1nynHPaQHmaNXt8aSUtd0Whb1EbshS919E14EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5QJX17hQj7CiWBNvHTLgpAoUUGQB9oqL8XZJCWyAHE=;
 b=kKO6PjRgEQKAarCRQ+sK+upPOPwsCFah04PljdEGefizHFMXp9SWk65RW3OhGEXx2taFMzbb3dX2p2OI4Z2rPHx+QtwW948NhiiG6ubVWacubNM+8PaeHw1D3i8yo0oN5a6Dcc0ADrZxOEZ+dULV4SuvsD0Mkdd1W3hpfyYj6SDDGKoPZBcN2ikroMmZxMI80xC1c5mgQCIZuLcRWb7RaCQrIJ2ITw02zFRgcr/TXWUv601Plo2ZfsE51mzvzFdmf8DRXAiF1m5ldDi4mmOm2bryCVCk/XZMXx3bBuawOild5qwsxqPVQohe1lfxE3JAFtlmOCras0ynOeM/cgR6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB6883.apcprd04.prod.outlook.com (2603:1096:400:33e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 03:28:49 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13%9]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 03:28:49 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Wang Yugui <wangyugui@e16-tech.com>,
        =?utf-8?B?QmFyw7Njc2kgRMOpbmVz?= <admin@tveger.hu>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH] exfat: handle unreconized benign secondary entries
Thread-Topic: [PATCH] exfat: handle unreconized benign secondary entries
Thread-Index: AQHZJcSyWxifT0vDp0GGjog1cb3tYK6aHBaA
Date:   Thu, 12 Jan 2023 03:28:48 +0000
Message-ID: <PUZPR04MB6316211446DB46392FE9581481FD9@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230111135630.8836-1-linkinjeon@kernel.org>
In-Reply-To: <20230111135630.8836-1-linkinjeon@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB6883:EE_
x-ms-office365-filtering-correlation-id: 381717b3-209d-48dc-b8bd-08daf44d1ea1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ak/PFk0Z1HOBEAjKfO4MomyJU+Aewb2SEtrcxZlhIkHIHQm950WMcpDaG29/G8v/4H1e1gm4aODMjqGMrPynoqUri2Ifp/3oZl+jMsHH5fMM9bnxCJ2wpL8p7Q3aZdSVidHXLlizz1MrtCk/eNz2ApliGzn9bZo/4ysH1R61g/yyuPZ+YTNJj92SJWT2laiot9H7rnWetLoH9kUe/luhi7Qm6kL3BbQxvz/KkbIOeuF7LwJnWXsIvZNQIt0N4u8lkm5JEoKAViRP2vsFmBqx+fWJvheAlPdfMP8opO2xZpODtzpZ8LzXpy7/PuGS7pPbPpWMeAT8G6pYNZBcBc5PeFKBdCfCnw8Y00EVbgVlapbmaKzGcB/FswhqeuH0Mv91DUXKQnaYpIXW6Hd5w1kJHIMmE95iuWw0PB0MkIhISmihd8QAVJoBVljgHzZOsOHlaOA9DZyYyn2lWX6zpEsQnAMc099W0qsDCaUp+CZww8FH4op9DaNweb3hFk97AaW9w1NA1xEgbwYMp60EGGjpEGPSjsUkpp+tAKQ3heFlRWdrou1rhTGNU2Ut/9uYWlU/mxgeFebMNszRtXm71h+cHIA4Reg4L4TXDcWHobNZLVR3O4xG8JituAZlpKn+j39ddkXq9cwQXtVmOdsOVD1eOKrNw5PBcO9oEjDgM6Vy++m2Lr2sqedCNZC2V3GNCdu08oyTnqDOzYO8FOElpFoCbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(107886003)(110136005)(71200400001)(478600001)(9686003)(26005)(55016003)(82960400001)(558084003)(38100700002)(122000001)(38070700005)(33656002)(186003)(6506007)(86362001)(2906002)(66446008)(66946007)(66476007)(66556008)(7696005)(8936002)(64756008)(52536014)(5660300002)(41300700001)(4326008)(76116006)(8676002)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEFKeEZ3dWVtOXhOZGFjbVpOVzdNK0YwejQzMUowMnJIVXlCcU4wMFM4aTNG?=
 =?utf-8?B?NE00dElSbUQvUzV0OUF4VWd2WTNKQmN6eCtLcVZVYUpncWlOK1VYN3hOVXlL?=
 =?utf-8?B?MDljaHVNV254UUtUd0UrbmlWRnkxL1NoTG90RXpjQTdmQUFPditsYi9xVXFy?=
 =?utf-8?B?ZGxqVVU5aU5zMFV3cHU5dTBuMkx3dEJaZEE4TnV0cm5zMWZLaUxoRmhYemhI?=
 =?utf-8?B?NkJCLzhXTTFCMDVDYm84ajBYK2lURjNDTmxnVzE1SE9ON0pia01HZEo5bXpa?=
 =?utf-8?B?ajBYUkh1UGFid0Y3T0xRazFGVkZnbWY1TUthN2xFMXBPNWVta0RrUll5MmM2?=
 =?utf-8?B?cjdmRGlqRFkySWFtVlA1Y2p2a21TZStuN1BSbWdWYmZkcUdtVXh0bGJKRGFo?=
 =?utf-8?B?eXV4REpSaWppbjZZL2p2b2Z1Z3hLVUNVWmR3WUpmTFZWUzNZN3RtenFTbWJw?=
 =?utf-8?B?aTdGN2IxNjNSMktwMlNoeGZ6RnVFckNlWGtyMzVvaXlhaUFRMnZxMVVnUzA0?=
 =?utf-8?B?akoyc2hkaXEwQXd2OUdzQTVXZEQ3NFJJOThwaERPRVA2QnkxYlBrbFp5dzAx?=
 =?utf-8?B?RUIxSmJ0UGI3V0dpY1NWZFBhWEJwUjNlUkZQUUdmaGliVHR3WWhaMmdIalU1?=
 =?utf-8?B?L2hSZUhxNjNEN3grcDIvL3Z6a0VDVEhCMWhmeVl4NEFScTVVMS80WmVUM2Vt?=
 =?utf-8?B?d1UrQUNWVU1wK1MxTSs3WHZLT2MwUWFsK3ZzL3pIZm5KMTd1RFRyWUpNWXU2?=
 =?utf-8?B?ZVU5SFQ3YUJoWjVveDZXMEhOdVpmUktZbWljSWJIZ1plRTR4MHhNbTFZQ1BD?=
 =?utf-8?B?YnZnZ1d0ckx2Q3owWWd1ZzJ0Snp2WHpaVnNLWDV5KzZjZ3pjdWM1RUZJWk0y?=
 =?utf-8?B?WUIvWmltREpIWVZHV3NQOXZ1WEsxVEpESUdpQnNEMFVUNmo0bVJkcXQrSnIr?=
 =?utf-8?B?Sko3ZTN6Q25wTTdOSlRyTlAzTkhsT0hrVnJJL2grTXJXUFo0SC96TmVod1Bm?=
 =?utf-8?B?MHBMbTZPMFFXL0g3cWhpZTRmZ1pETWU5ZjRJUmxNVys0L2Zla1BhblVYTlU5?=
 =?utf-8?B?NnhQSVhrTnJjUVBtTmpmaG5LZ04xWHBtVHMwcGhYYnQzcFFMVmZJL2lUd1pJ?=
 =?utf-8?B?eU1HVTgvb2JrYXJLTUVQZkt6Y3N5eEdZOE00eHl3SGkwUVo3bHN2VGdXbm1z?=
 =?utf-8?B?TWdHSWtILzdBWjNLT2x1VUF4SVVrWmZRZFVJdnJkVENQM0YwSHZRbTh5anU4?=
 =?utf-8?B?a205azJDVHpkaUExbGJpRVVXUDA5VHpSMGwvT2F4eVYrT01PZXBYWEtnRkFK?=
 =?utf-8?B?VDg5dTR4OVNtM1VSN0N5bW5FdFFUWGVLRS8vc3VTR2xLWWxSUVBXdU5RcU1F?=
 =?utf-8?B?QUJrUXBrampSaTRhaGhybnYxS0dUY3lJZ0QvNEFuM0NKKzVRS0diNzdFdVdT?=
 =?utf-8?B?TDdYTG9MNlpvMDV3eVNQazV0YW1hdVZpQ2pNbHNXQXVNTUxpODkwUkprREdK?=
 =?utf-8?B?UHl3RU44cERRNlJtK2lzYk04RTF5dExsK0tnNmxQYzZORk5zMnlpd2VDZnlu?=
 =?utf-8?B?Q3hWRzdhOW9vaFF6RUdSdklHSTdMM1F6ZkxvS00vTURyMHFET1g5MmJsWVBH?=
 =?utf-8?B?dGFJem5GRFBiNjNXb1lTMlVueGIzSkV5ZmtNb29JaTBpRkszeGFyaURITVph?=
 =?utf-8?B?YzNodmpDMklobWptaHBiVkhNdTVwbk04UEhmSWovN0NFdFM1RWlWSG13aTM0?=
 =?utf-8?B?K04vY2VtamxxUUNNdVVkSVFSSmlIby9rVTdRMzBkeFlXUEJPRzhZVkJoajdQ?=
 =?utf-8?B?TlpNM2ZuaUJlOWt1Tjl4SkxnU1N3ZVYxRnphUU9zV2JpUlUrakI1TmsvVDJm?=
 =?utf-8?B?UURlSFBMQmFlam5yVE9UWnErSWkzdlJEVWVtYndzcEo5Q1VsMXNXbWxEV0l5?=
 =?utf-8?B?K05YcStWQlVkeXNMbVR5Ui80bGpiT05acnBOcVZWU3ByT0hzNmRmNGhBV0JS?=
 =?utf-8?B?NlZFYjZTWkxhZk9hcm9PSkpnM0xVUDhKSWlyWHFhcFhNdkcweHJVY21ENmZW?=
 =?utf-8?B?WUw1alZvQ3RhSnVKTDBZWG1JL0RCK2lkczBsczhESzlacHBTb05ZaUFOaERm?=
 =?utf-8?Q?ATre8YxPQWnVsVCgqUD/yONBm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NEEMRyyni8rHmyDYQtIfCteGM2LB3YS1VD670KV14YoM5OuqV+rmPcgHKTukeeJ3bIPjqnMsUpXnc9tw+U/Am6Cje+Gc/u7QJsKMtTwZukCIKp+dKvTPtVmZG6i7lbWH+ax5TVARL/D1UPZdWU+8Zu+BbVYFDlDAVuqa6TYrNJESKIhnjyX/1I2m0ryEe8d85L3lSN2RQo0FPwhCvwi3N9nsFjlkdNn3HRAq1rTGcDguqTDvX21YYd6dvsQUQyXNHNlI82WzBmTMR1Irxhsv0yogWfUrVQU+qPYN+zZuaAqnytkxCEH41BMloBU08NsLXF3sdd5/SLICRP/+dNwOLA8APm4/gEZjK6oc0E6B4QQk5cuw8pEmqWpOYrOzg8ZCLVPBieDa/aVDd0FV3PCNKIWf03MS14wzFg2ZKs+f1rlP2hhkyN0m/EgcNMCGTdUh7R/tQMim4gbYNPkPJFbj2bCAv6X0MHnun59UqFR4sS//so/QiEM0PFeYOUN98/ITR+JK/pyEWi8A0Hzr3WQTmg1kHoSeY6fmLK2XhusWS9nv3NXjHC8iLNkeQGltmybyza8lV4v2jnIFFjVU5LxP+cP4ZvF2QD/xC6QTQ+K7D2/c/xvOTHvCV096Mvg4sb9vraNBJnFhSGe9JZJJ2sH+7qOZLr/bFosxFSLnw1Ti5X+R7CXqxgK4L/i2ldMrJF79XjAfDxrmZMLJrz0i+AOWf+ZqhdoMXmzE4tGkI1isL/LPq388rRZM1r4TDCdwFrFmBVpEvXpODP4kbjZKhcXIMwAjAmN8xgqcIodHKjb9hf/hGajZD2wqgCZtl3foU1bWss2X+WHnTkuoQWbPXhzZaqZoh8SBtdOvFOO8w5o8Af+pYdCVB7JXBWC21zQG0M8ik51gmtRejaxdGfLwSeRqSg==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 381717b3-209d-48dc-b8bd-08daf44d1ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 03:28:48.9607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWjv+rM6V+Clu/ggYrQzoYPwkbdjMZN8/+lKgyII9PHmkZ4+IQigBgEQ1AE087B1ZJnOeDaeTFNRdMwoTtjcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6883
X-Proofpoint-ORIG-GUID: nTRhushvrGr4JlXixkzXibQ8VNDel3xd
X-Proofpoint-GUID: nTRhushvrGr4JlXixkzXibQ8VNDel3xd
X-Sony-Outbound-GUID: nTRhushvrGr4JlXixkzXibQ8VNDel3xd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_01,2023-01-11_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rm9yIHRoZSByZW5hbWUgb3BlcmF0aW9uLCBpbiB0aGUgZm9sbG93aW5nIGNhc2VzLCB0aGUgQmVu
aWduIHNlY29uZGFyeSB3aWxsIGJlIG92ZXJ3cml0dGVuIHdpdGhvdXQgZnJlZWluZyB0aGUgYXNz
b2NpYXRlZCBjbHVzdGVyLg0KDQpGOiBGaWxlDQpTOiBTdHJlYW0gRXh0ZW5zaW9uDQpOOiBGaWxl
IE5hbWUNCkI6IEJlbmlnbiBzZWNvbmRhcnkNCg0KUmVuYW1lIHxGfFN8TnxCfEJ8IHRvIHxGfFN8
TnxOfE58DQoNCg0KCQ0K
