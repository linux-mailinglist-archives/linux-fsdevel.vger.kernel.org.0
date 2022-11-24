Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5B637278
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 07:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKXGll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 01:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKXGle (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:41:34 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C63E14E6;
        Wed, 23 Nov 2022 22:41:04 -0800 (PST)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO6WRUH002142;
        Thu, 24 Nov 2022 06:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=xKKeZR6+SXGUXOimF0GeERuS7BNE4wQS3IqZd9D2IJ8=;
 b=p+6bY9cLsuAK27uPAhoagIkDthV5QdkTr/3G+e9zZD8gwt54cdrWmP0bc+7X328tB/P7
 cPyP7ctoV7QAhst9zQ7u2R9Vg+OWIYaXQ2lTmgNvYHcZdcASeoRg1KegqkilhChX8Ddg
 iCBGrwz+U3NJ4di8UefBQ/8aTQaaPeLvNRLKK3IwQIbb8r/iPIaF69sBNG5OqYaQx2JZ
 TzHvgy4UMxc97Y1sKfWo2T8nyIAFyAUgH58BlQggj2mrZa6Y9VqYgrTsU+TV35h6d+J3
 lDp87zRQfEkfHNcR9mP9cwtTUCxuSsK/YM/Xy4KDpuWDX3waESdmcD3/uuVeInZRw7k9 xA== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2042.outbound.protection.outlook.com [104.47.110.42])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kxrd5mtxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 06:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fszdXAvc8b/a2/p/hsDHTvE3JgZ/kZoVQvBB66JpuxasbhpOgQiccdmEATWJ4IPQCIlFmEoIFIGTv10bGrq3ssa36QE+YixbUmdF41BRcKY1k7sC9KNa9P4TxGhwQctrB8/1Sh30OZTPeEYdGyTHVaouy84IoujOy55Evl5kB+nbcBSJztTyVV4Z4kizHyEGObc85zWFwASfmuu73c30yCXAGw1EFsse84+I7sItUmWZe96LJN6pCvspRnAKJ/ao6mx6jELLmC0vK9erhn3FZCk/mdVVatTHjZACe8KW97A9nHaLqyItypj8XOkT0ovMRnyL9+Wzgip3lemIQsuvXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKKeZR6+SXGUXOimF0GeERuS7BNE4wQS3IqZd9D2IJ8=;
 b=PR5CfzZ4PhbFL4RJ2HA0rn/KLfVFBf+KbBiTv8ozOfsA50wmDX7rwy0wmgo0tZGkO2lzPjiwbOBF4nH0ao6LyjuNy8csr9f88lEYO5JeB37Z8mIoZMYBxolh7KBw9egYl87MckQ664egY0H+bAT1AFk2vnGHkNMzvX1opSySECA+OcBkkcDl8aGJHJVmIP7VOcG0+m674fkHlNO4AMLzY9dGXX8YOZ0/RYehBjgIXOaiF7Ww9czbsHCil2LRFxR6BmHhDHjXWgmDFRTaEPBkORqFWAxV7JwbQwnjooLXR9OFvZPj2xeXBnR/G8I3T4/aIwuG74f2h6awSD2FHX4wKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB4425.apcprd04.prod.outlook.com (2603:1096:4:e8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17; Thu, 24 Nov 2022 06:40:40 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%8]) with mapi id 15.20.5857.008; Thu, 24 Nov 2022
 06:40:40 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 4/5] exfat: rename exfat_free_dentry_set() to
 exfat_put_dentry_set()
Thread-Topic: [PATCH v2 4/5] exfat: rename exfat_free_dentry_set() to
 exfat_put_dentry_set()
Thread-Index: Adj/zhk3xAnUZqh9RdCn2jEE9Dr+8w==
Date:   Thu, 24 Nov 2022 06:40:40 +0000
Message-ID: <PUZPR04MB6316E211D778619133DBB075810F9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB4425:EE_
x-ms-office365-filtering-correlation-id: dbea7db0-c004-4aca-ba01-08dacde6cd96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5SgMZfZR5mvN7U7ghU2GyB7f6VbvoUHQdiXQCLMkDv/iZfdbwX8lVdKicXNBPqJ/0lLeqCDscQWXqKz9G4cSNfLTjC4xb0pB7M3NvfV5iagkchTdWleBlVc743fZecoobvnmxL0mMjlim7x00+LBGuzfThL9krMqvmPAIN6xKvnBOPsKuv9Cc1OSaVDKxNbocVAG6TvhBAohMuYUIi2rMK1TfMa3tUJWUh9OVoaDC5lUne7fR7FoemKCTSLrctSZSpNpVW5t8mfqpSY0praZphaPw0F0ILdxwUHXEXkByOviZr1OhEzZUzjzWE4rBv4bAxST3qaZQP4MZXcVWxS6DXTO8SnnWYy31J2LOc/AtfFJ61JzesnexVjn7SVIqhu7V/wCmyErbnKpiM6OGeVDkIHZoqthY/W7+HMuAvbTTImXTwoLNzza5jqT9uoIdu5Of4qH9hNf0dSy0ByXH4JDw6ReaImxKbCeP6ASI3a3T5R6JxMh6Rafis1qRJMg768eujWZ95TUkKNXNjbRNTj9jrVKtsmaHzUzWRFhCp61u3sCaN6pkXN5TcBHPut4JyGZPVmSwTHBAbbgvLPnTSvnjjwa+lPVXJrDCIzQ67VjTIxQmD6rMfsCq96ZfOLWbw+wteqMbs9dQsvjCKEYy7KfiHKbvvI2qCCZao6YmTh8Z0DLOubDAEr1aE/weGY0v1Iiabg18TZOlmUDBNzeINxmXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(41300700001)(8936002)(478600001)(54906003)(4326008)(5660300002)(316002)(66556008)(66476007)(66946007)(76116006)(52536014)(66446008)(64756008)(8676002)(71200400001)(107886003)(2906002)(7696005)(6506007)(9686003)(186003)(110136005)(122000001)(26005)(38070700005)(38100700002)(82960400001)(86362001)(83380400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEgyY1hrMjBza2N5akM4WlZweFA1c0dhKzNjRUpZVHpEUml4NUtoOExaNHBl?=
 =?utf-8?B?S1VUMHdtaVpZc1NQT1VrV1BOUytmYUxFeDRRcUVPN2Jvd0NxOVM3R1JsOEhV?=
 =?utf-8?B?bTJ1N0RYMFN5US9OYjBvZUE4ZGxxT3dRQkN5NWpNZWxxak9DdnpOMTBMMkda?=
 =?utf-8?B?dnZFbnBWSlE0NEhLOWN1Q0JmckJjbFp2Y0xUREJXeTlnWitvdzV5cE5HenY1?=
 =?utf-8?B?NUIyTkFTV1RtcStFdWFIL0ppRFFMTStVdURvdDlyVENhUlh0OUlJOVhPVWlj?=
 =?utf-8?B?UTZyam54QkRGZ01SVS9xK2lBNlZYRUVieXp5anV2WnJOZXY3TE8wcE1ONmVC?=
 =?utf-8?B?OTlGc2Y2eDRiRUlnckxtMzZVbVZWWUw4bUh3NW5odWtuazdFTDRKaW8vWUFL?=
 =?utf-8?B?WGZYenFOK0hMK1YyL25Td0hnQnJpQUZRK2YzT2hGelBWTHU2MmZvMnJJTjFD?=
 =?utf-8?B?VFNmQk1hdkRNKzJOTG9tTTY5TjN2b25VZFpaSVBpaVFSN0RlcE9kcmFmKzNV?=
 =?utf-8?B?dEh4VnZQSkRWTEdqQ1ROWnhVT1Z2R3F6bGo5V3VSYmFBNEw4KzZHMFRpMjNY?=
 =?utf-8?B?RkxWWlhkWGM0elpWMEZWK01IVERzUmtWYXIwUTRab3BhSHorOXVXQWNVZk8w?=
 =?utf-8?B?MWdHMjNuaEFYL0QvVlRtQjEvTnlTNk8xekI1bkpOYjYzQ0tWUGpTWkVqWXFV?=
 =?utf-8?B?bkp4OHlQTitCYmljYUZYa1VxMXRzdzlQV2l3RTlkNEwxQzN3NlpSVFNYdm42?=
 =?utf-8?B?VjRVZTVuUVBIWm9RYnN2b1lEb1EySzRuY0hlQkdQOTczTnNMczk1YjFzTlZP?=
 =?utf-8?B?akp4OWUwc0lvdjJhWEowYjlSOFY4TGpmNmFkdGR1aWtyem9IQXk3YThzMStt?=
 =?utf-8?B?YW9Od2dhOTdDYnc0U253KzRnQnpRaHkyRGN6d1E2SlFCdU1HWXpFdWhMTHhG?=
 =?utf-8?B?TnpjZjUwa0FkMGRKMEtINWZKQzJobXk0SGkxUWFZUXRtRVY2WE1IdVM3UVZo?=
 =?utf-8?B?eGlEa2pSc05Bb1NjbmtLYUNMQkt1UU1XNlNPZ0FqM2hiajFqT0Zsb0xzMyts?=
 =?utf-8?B?Tm9xRnlVNFh0OUNNU1RyN0dWWWt5aStUNzY2V1k2WVAyNW9yUGg1SXBPSUpS?=
 =?utf-8?B?UC94bndjcGNkRmlMZGRmd0cyMUsvdTYrQlhaVjVhdUZUZFBhQ21aa1ZvWnNE?=
 =?utf-8?B?QUVPRzRFbHRITHBiSkJQdk4veitJWmRzbURMcEdtTEJmakhjdGRON0FBVTRK?=
 =?utf-8?B?TUtUN2wyN0QxMnE0MkZGWTFsTm1Wblpyd0ptNHl4K3N4Q0NqdXV1Ly8yRzFz?=
 =?utf-8?B?MVJ4NHhTTkt3WWdHTXNVbXcxeW5kNUNCWHBUK1k0aVZNQVRvWjh3dzRKTDAr?=
 =?utf-8?B?MXF6VHpWSVUvSU5zdlI5a24vMSs3OU1HT2psSVM1RVRXdEVWMG5hZXN5NS9G?=
 =?utf-8?B?UExJQkliTVRVRmxTQTB3LzNXM0J6OTZVUjBqeGdVNm5ibWdMVGlNczFWSnp2?=
 =?utf-8?B?Sjg3MUdBVkdHb0R4ZHBuSitxZThJanMzaXNRaFpyZkJGRDR6UnFadFQ1YWhZ?=
 =?utf-8?B?UjU1dmZiYmhhTnJxcmMxclBLMHczK1RxNmhoUU5nWnJ2SWp3NFFjQjdkTTVM?=
 =?utf-8?B?dCtnWElsa2JvRjJ4TXB4QkNNR2FGMHUrakdRaVRTbWRKQzNIZFNlME5UZEFS?=
 =?utf-8?B?Q0JhSHpmRkVMbnY4eHFhMmxhRy9Qd0lBc3c5Sk9OMVpLRDh5ZkcwRFI1dDNi?=
 =?utf-8?B?VEZzVzBEdm5Rc3JWUnZUVGxWYkZhRHppTmpSWTFuTktMdExZalIzRTVVdzRR?=
 =?utf-8?B?UW9YZTZDRlpCbHB1T2JIaTlTQUdVTVg5OW13M1NLMjZwQUFyWUEveDlMcDBv?=
 =?utf-8?B?UkZ0Z0N0N2pBT0xzNGZiWDQzS3BPK3ozZHpaUFk1YnJwUERUdHY1dExPSFBy?=
 =?utf-8?B?OG1LUFZhMDQ1VmhLcVdMa1FhLzBBZExJcDVORHJIZEFPWHVsOWpNUkIwbTBt?=
 =?utf-8?B?VlpUQ0VGQ016MmZ3UmhuQi8wVytzblBHQSs0Zmk1OW1Fa0dHb00rUC9kelNC?=
 =?utf-8?B?NWpMTmpTRjZpbVkxckl3VzBNV3dsUDZXTWs0MXE3SFp5bWFkaFg0d1BKazA2?=
 =?utf-8?Q?f+qPY6iOShVG1IqBQjbi2ZOTA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3Gj2Xju+4iJNP5D5F4viA8bfOCMFr+7bK95Uk51BWNs+vhiWXQ0brkR0qZS1gAOa41QuWQ2FMY+0jV9B2dOTKxml9XoEZkqlgFt8GuHZYUTbb0MQC/zYRo3/NqBg1SG5kVUr8GFXd8cvRQgGYE/z+LQANcR6hQ2n1QznBfPwE5S2mjC3Fn6Zhrnr7kHxQtneGsC98YzD7IKL3tzmEIg+Abyi7oZbJ0MdqaGo+XEfEN+B8/k+K3eiIPrTxokIJEtlptUpcYgAcUQyy2zKX7JwWd6Vp4nLL4AjDxV0AQ2Xn6yVMdfAJydLh4PFmh7n9zjC2TPrxZoTe72y7Yvh6nHbQRvlXFAL3CIh+2WsEyDBsH6ppwxmf7ZCdppeiJ392fWBThN3hMQ/psv0qPK50u8zr3QTQea59SItgTB2MIt7D5pjNwaT/LDqBXIrRXD+Ub6yC24q0FiVRR50fgbBKRrUtbG/f07nBHopvZRR5Gr/zr66h9PSZjc86Rf7gjvEEgOS3E+JK34YxwPKTEkURDZNvjE+1JQvOprKJMZx3iNDE3OoR5jHZt7ZqHGKaeBW30hm4exde0DRKZ/QVDwB617OhwX2feQ0abMaT+BQXUBkqwudTwpVKUmgevncSYjVlc3r++uT+vfMcQAXTYCj0Ims5f79AS8gAlUrNeEop+XHpH9noTEIV+/lM8mzgsKrjfszOQj187fpzdu0PyLhrFs3017SPAtHtasja6CdDzSqAYQc/GbRROn9vB9B6h2ZpKWDjUZHMLrxye/ZCVaamZ+vn7i0+xAT0g7cUr/C/6lPFVLLcnRGbK9uBFJMPQAx4vQCGwIT8FfXknrUgsm74CDMUTxxhvyRw53RPJksFx+j98UEfGPhdiIb6QFAGYv6llxO
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbea7db0-c004-4aca-ba01-08dacde6cd96
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 06:40:40.1101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRZQJx1mwaPjRVai3kn/Ck4v0llp3kQ6qPElqCSAYAoIcpEpD57+QAo7xrITQppmrt0/ZCJV5nuNwWAA694bMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4425
X-Proofpoint-GUID: PpyTMHDIQlcsQcAQ0utRvtNjeZqFq74W
X-Proofpoint-ORIG-GUID: PpyTMHDIQlcsQcAQ0utRvtNjeZqFq74W
X-Sony-Outbound-GUID: PpyTMHDIQlcsQcAQ0utRvtNjeZqFq74W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_04,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

U2luY2Ugc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSBpcyBhbGxvY2F0ZWQgZnJvbSBzdGFj
aywNCm5vIG5lZWQgdG8gZnJlZSwgc28gcmVuYW1lIGV4ZmF0X2ZyZWVfZGVudHJ5X3NldCgpIHRv
DQpleGZhdF9wdXRfZGVudHJ5X3NldCgpLiBBZnRlciByZW5hbWluZywgdGhlIG5ldyBmdW5jdGlv
biBwYWlyDQppcyBleGZhdF9nZXRfZGVudHJ5X3NldCgpL2V4ZmF0X3B1dF9kZW50cnlfc2V0KCku
DQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJl
dmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFt
YSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9kaXIuYyAg
ICAgIHwgMTYgKysrKysrKystLS0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgMiArLQ0K
IGZzL2V4ZmF0L2lub2RlLmMgICAgfCAgMiArLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAgMiAr
LQ0KIDQgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9mcy9leGZhdC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jDQppbmRleCBhM2Zi
NjA5ZGQxMjkuLmE5YTBiM2U0NmFmMiAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQorKysg
Yi9mcy9leGZhdC9kaXIuYw0KQEAgLTU1LDcgKzU1LDcgQEAgc3RhdGljIHZvaWQgZXhmYXRfZ2V0
X3VuaW5hbWVfZnJvbV9leHRfZW50cnkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwNCiAJCXVuaW5h
bWUgKz0gRVhGQVRfRklMRV9OQU1FX0xFTjsNCiAJfQ0KIA0KLQlleGZhdF9mcmVlX2RlbnRyeV9z
ZXQoJmVzLCBmYWxzZSk7DQorCWV4ZmF0X3B1dF9kZW50cnlfc2V0KCZlcywgZmFsc2UpOw0KIH0N
CiANCiAvKiByZWFkIGEgZGlyZWN0b3J5IGVudHJ5IGZyb20gdGhlIG9wZW5lZCBkaXJlY3Rvcnkg
Ki8NCkBAIC02MDIsNyArNjAyLDcgQEAgdm9pZCBleGZhdF91cGRhdGVfZGlyX2Noa3N1bV93aXRo
X2VudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlICplcykNCiAJZXMtPm1vZGlm
aWVkID0gdHJ1ZTsNCiB9DQogDQotaW50IGV4ZmF0X2ZyZWVfZGVudHJ5X3NldChzdHJ1Y3QgZXhm
YXRfZW50cnlfc2V0X2NhY2hlICplcywgaW50IHN5bmMpDQoraW50IGV4ZmF0X3B1dF9kZW50cnlf
c2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLCBpbnQgc3luYykNCiB7DQogCWlu
dCBpLCBlcnIgPSAwOw0KIA0KQEAgLTg2MCw3ICs4NjAsNyBAQCBpbnQgZXhmYXRfZ2V0X2RlbnRy
eV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogDQogCWVwID0gZXhmYXRf
Z2V0X2RlbnRyeV9jYWNoZWQoZXMsIDApOw0KIAlpZiAoIWV4ZmF0X3ZhbGlkYXRlX2VudHJ5KGV4
ZmF0X2dldF9lbnRyeV90eXBlKGVwKSwgJm1vZGUpKQ0KLQkJZ290byBmcmVlX2VzOw0KKwkJZ290
byBwdXRfZXM7DQogDQogCW51bV9lbnRyaWVzID0gdHlwZSA9PSBFU19BTExfRU5UUklFUyA/DQog
CQllcC0+ZGVudHJ5LmZpbGUubnVtX2V4dCArIDEgOiB0eXBlOw0KQEAgLTg4Miw3ICs4ODIsNyBA
QCBpbnQgZXhmYXRfZ2V0X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAq
ZXMsDQogCQkJaWYgKHBfZGlyLT5mbGFncyA9PSBBTExPQ19OT19GQVRfQ0hBSU4pDQogCQkJCWNs
dSsrOw0KIAkJCWVsc2UgaWYgKGV4ZmF0X2dldF9uZXh0X2NsdXN0ZXIoc2IsICZjbHUpKQ0KLQkJ
CQlnb3RvIGZyZWVfZXM7DQorCQkJCWdvdG8gcHV0X2VzOw0KIAkJCXNlYyA9IGV4ZmF0X2NsdXN0
ZXJfdG9fc2VjdG9yKHNiaSwgY2x1KTsNCiAJCX0gZWxzZSB7DQogCQkJc2VjKys7DQpAQCAtODkw
LDcgKzg5MCw3IEBAIGludCBleGZhdF9nZXRfZGVudHJ5X3NldChzdHJ1Y3QgZXhmYXRfZW50cnlf
c2V0X2NhY2hlICplcywNCiANCiAJCWJoID0gc2JfYnJlYWQoc2IsIHNlYyk7DQogCQlpZiAoIWJo
KQ0KLQkJCWdvdG8gZnJlZV9lczsNCisJCQlnb3RvIHB1dF9lczsNCiAJCWVzLT5iaFtlcy0+bnVt
X2JoKytdID0gYmg7DQogCX0NCiANCkBAIC04OTgsMTIgKzg5OCwxMiBAQCBpbnQgZXhmYXRfZ2V0
X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogCWZvciAoaSA9
IDE7IGkgPCBudW1fZW50cmllczsgaSsrKSB7DQogCQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2Fj
aGVkKGVzLCBpKTsNCiAJCWlmICghZXhmYXRfdmFsaWRhdGVfZW50cnkoZXhmYXRfZ2V0X2VudHJ5
X3R5cGUoZXApLCAmbW9kZSkpDQotCQkJZ290byBmcmVlX2VzOw0KKwkJCWdvdG8gcHV0X2VzOw0K
IAl9DQogCXJldHVybiAwOw0KIA0KLWZyZWVfZXM6DQotCWV4ZmF0X2ZyZWVfZGVudHJ5X3NldChl
cywgZmFsc2UpOw0KK3B1dF9lczoNCisJZXhmYXRfcHV0X2RlbnRyeV9zZXQoZXMsIGZhbHNlKTsN
CiAJcmV0dXJuIC1FSU87DQogfQ0KIA0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgg
Yi9mcy9leGZhdC9leGZhdF9mcy5oDQppbmRleCAyZmZlNTc5MmIxYTkuLjMyNGFjYzU3ZDAyOSAx
MDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCisrKyBiL2ZzL2V4ZmF0L2V4ZmF0X2Zz
LmgNCkBAIC00OTMsNyArNDkzLDcgQEAgc3RydWN0IGV4ZmF0X2RlbnRyeSAqZXhmYXRfZ2V0X2Rl
bnRyeV9jYWNoZWQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsDQogaW50IGV4ZmF0
X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLA0KIAkJc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwgaW50IGVudHJ5
LA0KIAkJdW5zaWduZWQgaW50IHR5cGUpOw0KLWludCBleGZhdF9mcmVlX2RlbnRyeV9zZXQoc3Ry
dWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsIGludCBzeW5jKTsNCitpbnQgZXhmYXRfcHV0
X2RlbnRyeV9zZXQoc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSAqZXMsIGludCBzeW5jKTsN
CiBpbnQgZXhmYXRfY291bnRfZGlyX2VudHJpZXMoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3Ry
dWN0IGV4ZmF0X2NoYWluICpwX2Rpcik7DQogDQogLyogaW5vZGUuYyAqLw0KZGlmZiAtLWdpdCBh
L2ZzL2V4ZmF0L2lub2RlLmMgYi9mcy9leGZhdC9pbm9kZS5jDQppbmRleCBjZGNmMDM3YTMwNGYu
LmE4NGVhZTcyNTU2ZCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2lub2RlLmMNCisrKyBiL2ZzL2V4
ZmF0L2lub2RlLmMNCkBAIC04Myw3ICs4Myw3IEBAIGludCBfX2V4ZmF0X3dyaXRlX2lub2RlKHN0
cnVjdCBpbm9kZSAqaW5vZGUsIGludCBzeW5jKQ0KIAl9DQogDQogCWV4ZmF0X3VwZGF0ZV9kaXJf
Y2hrc3VtX3dpdGhfZW50cnlfc2V0KCZlcyk7DQotCXJldHVybiBleGZhdF9mcmVlX2RlbnRyeV9z
ZXQoJmVzLCBzeW5jKTsNCisJcmV0dXJuIGV4ZmF0X3B1dF9kZW50cnlfc2V0KCZlcywgc3luYyk7
DQogfQ0KIA0KIGludCBleGZhdF93cml0ZV9pbm9kZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3Qgd3JpdGViYWNrX2NvbnRyb2wgKndiYykNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5j
IGIvZnMvZXhmYXQvbmFtZWkuYw0KaW5kZXggOGQ3MjUyN2RmYjc4Li41NzUxMGQ3ZjU4Y2YgMTAw
NjQ0DQotLS0gYS9mcy9leGZhdC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAt
Njc2LDcgKzY3Niw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmluZChzdHJ1Y3QgaW5vZGUgKmRpciwg
c3RydWN0IHFzdHIgKnFuYW1lLA0KIAkJCSAgICAgZXAtPmRlbnRyeS5maWxlLmFjY2Vzc190aW1l
LA0KIAkJCSAgICAgZXAtPmRlbnRyeS5maWxlLmFjY2Vzc19kYXRlLA0KIAkJCSAgICAgMCk7DQot
CWV4ZmF0X2ZyZWVfZGVudHJ5X3NldCgmZXMsIGZhbHNlKTsNCisJZXhmYXRfcHV0X2RlbnRyeV9z
ZXQoJmVzLCBmYWxzZSk7DQogDQogCWlmIChlaS0+c3RhcnRfY2x1ID09IEVYRkFUX0ZSRUVfQ0xV
U1RFUikgew0KIAkJZXhmYXRfZnNfZXJyb3Ioc2IsDQotLSANCjIuMjUuMQ0KDQo=
