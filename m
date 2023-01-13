Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C6C6689A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 03:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjAMChO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 21:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbjAMChH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:37:07 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BEADE99
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 18:37:03 -0800 (PST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CNebVI025587;
        Fri, 13 Jan 2023 02:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=DRVE1zZ17556jZax/P8cutHwBbbZ1l+aB9TZ94lMmPI=;
 b=GPVtVBM/XXIB2/nkvneLHIqAujCaG8cvV1dO98SepHJ6x7nEIFev8E9xYCuJDCCOEVeF
 WyDJoRmA10IqBY7hGGRRooO4q5u5oi5bAku2nAmJ7pNyx3c2xw79lnZgJXNeQ2GJytvz
 yW5rMQ4qXdSaespBxHM2bk8LyxgWMlQ21r92Tm2BCbGQN9m56ttcLDgxZznHA8pilxtH
 Lg2Pb16Na+LWztLw7uwrxLEq512m06/+VwXnQj6BEYX2iSPASf5nt+9QI3XBRJg1Zgkd
 WfzMhFG7LUDWzxYS78GH6qYocqYHI6BJSCgfsfhE1RtSUxvB59wS4urZnY6bEPZC2Uj5 Ag== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2044.outbound.protection.outlook.com [104.47.110.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3n1k7v2gck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 02:36:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WT4gBZMCB+9zjaWfPo5+sP2myqohPuDNTpM+ajpG7FD1qhNXnomI5dTg0FnYFp8d59mAgtje16QSuEFdli9VvmX7QfcyccvT9b5hgAs19Vb84iO2N5dWgKcKKRTjz2w8ktdtNa4Wj3WQKG1yrzJzS91BXo+Fjng36cMd6c8uDHjViAdwbPBJvWdxbJAbaVYBDo6MalLhyF9g57VX3Of6zoNw5ZFeXzY1Rv3/SAcJBDyafOaTaCLcrzs5636/+OOGjy8JuwiShDVSB+aWsaXBdsV1TntudNmK0M8c2Wi9RGykD5jIQl3B3wj1sjRnPUpNUD6OysS/ys+7RXqOioQ0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRVE1zZ17556jZax/P8cutHwBbbZ1l+aB9TZ94lMmPI=;
 b=Ocs+BJu0/PUDyiJKThZj9o2ixuoXF4LG1qhe36bICCfcHs/1gJy3X5tKGCJifOBgkWg05Ore0+PAc9/+h3bFO9OjhJOz0efxEUSvM9xKT35B1q7Ua0OQ3I0IBJ+rWLQud18ghPGqahOBjIpJU73jvIeCF1JWihxX2U/Iy41gnT3D4LZ58RbcH5iSWdkX4kR+hle5qw1ZQ7BizPjJEOWi5x80pnQCMSc8uk+Q3e8IGrJb8+XJbPFwok8gbivL4OFAxxE2HQdVaLkbkAcn2Yfwm/X6sELWMDoTaE/9x0duoNNlCP9kewg4WGWdDEHW+5wCpPhmkdsEvZLw1gWZ39S4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB4347.apcprd04.prod.outlook.com (2603:1096:4:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 02:36:01 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13%9]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 02:36:00 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Wang Yugui <wangyugui@e16-tech.com>,
        =?utf-8?B?QmFyw7Njc2kgRMOpbmVz?= <admin@tveger.hu>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: RE: [PATCH v2] exfat: handle unreconized benign secondary entries
Thread-Topic: [PATCH v2] exfat: handle unreconized benign secondary entries
Thread-Index: AQHZJo7y5h16sYwNTk+h7l7ut+eKRq6bnW4w
Date:   Fri, 13 Jan 2023 02:36:00 +0000
Message-ID: <PUZPR04MB63165533693F8FD12046D19581C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230112140509.11525-1-linkinjeon@kernel.org>
In-Reply-To: <20230112140509.11525-1-linkinjeon@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB4347:EE_
x-ms-office365-filtering-correlation-id: 08aaecdf-b9f5-47cf-18cb-08daf50ee8b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J4qVKNYLwsEr/9l52eBzUd6YC9xqxE0pFDa8Oq1vx34/3iQDHHqUTiuNS2j1fiOef4nhgr6ReO7LMY74jSB97rNyxJyPVPYr9FSU2Z5eKEWeq4N5OV+hmnInfNfRlwSOZcf7a8PIThfu5mmN5+bm/gjyBlk/6LksmalIICzPtHF42lzDLk7Lo4j7gdhle/4hiNz7watu6o2J00ZwXjAK+biHqdRGycEtTzpUj4q/QyZgr/kWqpK91BKf3U2ldZjpKfi4WNDoODXoj7VfZ9CQD0nx16XmD9qBi396QdOP6RdTyHaWbplxhJVSAJLWb8cBWtnYitYwOcwYDx3HAHyrr/XjweZmIbcsUbOHinKg4qXq6LVlMeeMT5Gh71GPmURHELfjWRUZ+d4zr4fL/sGdYZPM8JEcrHH2rw3rXsl3ZVkaVSMxzsBjxGYW+h0XEQb7mJOIdF5OoF9Y7e2xmqzHdIZBgzlu+noyKERwescdmiIeFYFoEo6MsHMMYbQdWnUp83EkIQTV87iieldVLmkAqAbqhWcidzuYCGfk/G95ujUza1eO7bLWsQCu+vzBUJZLo7iyZGvGQ3Eu1TKp7rNxaWEqHLsmNhdBJIq7x8G7L9uKaV2cPMEc6DB7wqUTMQxt+f/cNyjmvuQTY2BwCf4+qLlyhKGV17mzhn+VauqO7IMuZL3r9fo3JGxohpke79X5pSqN5kgyKoWIS1ab4vw7OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199015)(316002)(9686003)(26005)(186003)(4744005)(478600001)(7696005)(71200400001)(54906003)(86362001)(110136005)(6506007)(55016003)(2906002)(33656002)(82960400001)(41300700001)(122000001)(38100700002)(5660300002)(52536014)(38070700005)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(8676002)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0VFaFE4cWtyMDFVdFZWaHdramxhR0xQencxN2JKM2JQZWMvTC9kUnhsSDNV?=
 =?utf-8?B?Q2F5OW90eC9jOSt6N1B3NHBNTERBYWJnL2Q1VER5T2Fra2NFS1lvSW04OEpw?=
 =?utf-8?B?OU5Vcm5aT2NUS01WTlUvcXJUc2xOYTdIbEc0QWpvbTlGZXY1Q0QwSEdOZXBV?=
 =?utf-8?B?QUIvR0phbGJScG9BWmZQa2wxd0x0RmMvdFl6cGVCSmVvR1NoYUJudXdXQkUz?=
 =?utf-8?B?NnNiRFVrcFNwRHh5Nk9PSlg1NmNzdmZJenlLcTdFSm9RRzVHTEMrdGNQSXFo?=
 =?utf-8?B?SjZoaVVTN3JTOWVjbGxQMnBwM0ZIcWc3bjU0ai9Ja3FISTh4WU90cWxrdW9s?=
 =?utf-8?B?LytNQjFQdS9CcXk5aVRjMWNzMjdRamxZaFhWVWZVc3ZYYW1GdEVQUUlGWmVm?=
 =?utf-8?B?T3E0cTFTaXVUZmhPUDFxS2lpc0kwQUxCdi9TNDlqMld0UHpwdzUzTWZQOWh2?=
 =?utf-8?B?NDgvc0dISTJ4cjk1SmFJeHF5WDVyMCtIQmgwUUxzclFrRlRMTEV6WCtiMTJP?=
 =?utf-8?B?TmVsazZ6Vmg2OHEyT3RhTE5COXpQVnVwbTBCbkpkZFp5Z3c1MnJ0ZVRQM1Jp?=
 =?utf-8?B?NEhNWmUrV2hxT0hyRXVkbFRwOCtjMmFMOC9SV2x5Vks3KzBRT2ZjbERHeGtK?=
 =?utf-8?B?eEZpV2FickxBcmJJUlVlbzAxbzQyc0luUThEb0JBTUprbHRoZllXUi9zemdV?=
 =?utf-8?B?RzFXSFpNU1pNc3A3ZjNDclZHd1YrY1M2YU5rSXpuNzUwSlVkdi9paTQ5dUV0?=
 =?utf-8?B?eWtoOC96c1NBNTAvNkFlQUdqZkVpZ2ZWMmlsQkhQbUpVOTQyTmRLOWtQZFlp?=
 =?utf-8?B?SDYzMnZEVU5SWGJRNDNzVUd4UE5yVFNiUTd6SWJyRHFWckREcE5oczhnLzlV?=
 =?utf-8?B?SWZRWUp0VXlEbS9zWUtYMmpuNHhicGVyZ3lYS29FK084eUE0Qm1wSlN0R25F?=
 =?utf-8?B?MlpkN1RiSDJ4TjRVaFFPcklRYUs5VlJKZmhxVGR6dXl2VnYzTEZrdkFvMFNK?=
 =?utf-8?B?ZkVjZWJjK1ZVMGlUVnBNempIM01VcFhkbUNweE9FZ3V3Vzd4bTlGeTF0YzYz?=
 =?utf-8?B?ZnZVdjdTUlgrZVo0d1Q1TFYwYWVxKzAyQzNOWnc1Ukx0TXA5TitFS2J2aXBZ?=
 =?utf-8?B?RUxmTlFXTE52cEduRlRFTHp5cExmVEZqbFJXVlU3WDJaVzA2VC9XeGJnSW9m?=
 =?utf-8?B?eFlibG9aWnBEcUdRRS93MTRhNHBHTWxRdm1UYnNvT0VIUmhIWGY3NitIWmdT?=
 =?utf-8?B?bk15dE5YS25XdVQyRzFmWjdvZFBibDJFMjBMOXplSGhHRmZaeTRDUkw5ZVZD?=
 =?utf-8?B?U0orUDBiaTN1eld4WDRIU1ZYc1RXbC93Z1VhSVpjMDkvRm1xdGwrc2RhL0Rq?=
 =?utf-8?B?SlJ5ODhSbmFBUVBwSm1ZY0FWbUxzb3Ywd2ZITU1LWUhUaUhtU1hPb0NhODZs?=
 =?utf-8?B?cEt4aDBUdEpVYWNhT2RKQnFwSnF2eWF5SVlkNnNEYXdhSHYvdThXdGkrRzQw?=
 =?utf-8?B?eTNObHRydGVDOG5pb2k0WDUxNjFES1B2M2hidjhlNklqaUhKSHJCYWc0ZjNH?=
 =?utf-8?B?c1NiZytSSkNIRFhFT05Hb3hpYUhSQ2dHOTZsNjVSVkR0QWJHVkNNZHZIdHMx?=
 =?utf-8?B?U1pnUC9Eb3ZEVDNtd3dRdk02TXZqbWhVYmFtTk5yTE95dTlPcC8xQ0paZXVV?=
 =?utf-8?B?bDZweU9jVUMyTlFuUmhxTngvUXlSb1RicG4zbTgrOVhLZmhlNnZONkUxVUth?=
 =?utf-8?B?SklPTGllVjEzNnhuaWZqTDZSS1l2OVE1bGpoaG9KaENYZkdWYXhwUktXRXdp?=
 =?utf-8?B?ZmdZMHJLK1poUnFwcU96TlNvNWJNRzNBVUpVYmdjd21ERmVaWDh2T2kvcm5W?=
 =?utf-8?B?OVNNK3A0UXRxNGxHdk9DbXdYVHVPSHJsVWdUcWZSZUFQcSt3bVNhU2RkdTkx?=
 =?utf-8?B?Qkl5NG1jRU1IRHplZ1hYNEF5cWhGV3FGa1pqWHRESjViTjhJdUxicnF2ZUg5?=
 =?utf-8?B?QUxnaWN6WEs1aWxkSUxMTG1ZNFJaeG8vVjhTejhNbVdEeXluQTZxM1h1ZXFU?=
 =?utf-8?B?NC82ZFUxTmFZeWtPZ1VsK1JIR0lRRlBNK0gyWFliS0ViaUhWeFZweWJVM2Nm?=
 =?utf-8?Q?zQu7k8Fi+JMLleZm0/CngFi9O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uKAg9X8Ishnj5YPFSznGw/MF2/5MG1fBIA8R+kl5d5urh19YJtMNG0oI1ysYEVi5MG3IZXytKLwHTfiI7/QbeM0+Uq+HHQjlyfpfQQ/IEO+daq9wU7XGVGKbSkeRHe/EiFTrKAF6anDX/lzhc1+J+jVE7JZir5mB1qYxsSESPRBzT+5N96XVcvi+oGj5DQXaFiO+N+udQKVBwp0vYMoBJ56J3WSUnpKq1CqaN2vhE9Lz2OG3KgXkEIRDOola0rLlPbxn244g2Rr+SqxAdN0Qte7HXGFiLRFtk9IQcplIkB1NjVHCxZshrUg/+TlSsjguEMuiWb/gsXD+8VyNNANJ8aH+uVwdysL5XePEPfc+rhqBzr/LBhhMF0m5LuG70IJcP0qc3sTmNYk0dh6LSMy4s1eTCT5/4scf470DO04uSd9PUmqwImLVY6tlDGjWoLBbtMnB62Tyi8jliwu+fA9hzDwkcqJcy1l2poEIG9k8hYuhWaX4o2RIaMN06Ydmxffax9vCp0YgEYJ22SUoa9zmXojM7/prnULe1+hpK6ueL89RRK5Y10uCfxv+FpezbYeTGibPo0ShRSGCEO0BAhBWFU+QAjGIKnq4U3ymnAZ661NtE8qbIeo8BTQgBu3tQGWIGVk7IBLaVJg2UuU6lStInzjLa5STw087CbrM5fbaaSM8xMJuGeUFvPU6R5WeQhBjxlYGHXKlCpUFVPclflBHWYHJEga8ufa0RE3az5IyDA8wTRCAjYO4OVQL0VAmGilZBmmODMAt36z9Jzw1C3rcrLdhiuxwjrtjUVmqsM7X/9px2TVVhNlIIyk+sgM37Fz020lWTvj8VEdvjiQV7rWXtskBCqNluNjTEYZCkRLWc9ndCvXVNUidC24XDtdKDiVbabWC9LMo5unWzd5TVTq3MA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08aaecdf-b9f5-47cf-18cb-08daf50ee8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 02:36:00.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvRJNSPOM/4x8y2lT7sCM9gBftx1FHpZghFT+Qyxxs6F0cQ/QBJVkjiuVRgcfIVMQv7nDTuc/tW8UcLifw+nFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4347
X-Proofpoint-GUID: YUoGZph4mDpsBSISRxjJ_w_XN5LiyZuA
X-Proofpoint-ORIG-GUID: YUoGZph4mDpsBSISRxjJ_w_XN5LiyZuA
X-Sony-Outbound-GUID: YUoGZph4mDpsBSISRxjJ_w_XN5LiyZuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_14,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiArCWlmICghKGZsYWdzICYgQUxMT0NfRkFUX0NIQUlOKSB8fCAhc3RhcnRfY2x1IHx8ICFzaXpl
KQ0KPiArCQlyZXR1cm47DQoNCkZyb20gJzcuOS4yLjIgTm9GYXRDaGFpbiBGaWVsZCcgb2YgdGhl
IGV4RkFUIHNwZWMsIGZsYWdzIGNhbiBhbHNvIGJlIEFMTE9DX05PX0ZBVF9DSEFJTi4gDQoNClRo
ZSBOb0ZhdENoYWluIGZpZWxkIHNoYWxsIGNvbmZvcm0gdG8gdGhlIGRlZmluaXRpb24gcHJvdmlk
ZWQgaW4gdGhlIEdlbmVyaWMgU2Vjb25kYXJ5IERpcmVjdG9yeUVudHJ5IHRlbXBsYXRlIChzZWUg
U2VjdGlvbiA2LjQuMi4yKS4NCg0KPiArCQlpZiAoZXhmYXRfZ2V0X2VudHJ5X3R5cGUoZXApICYg
VFlQRV9CRU5JR05fU0VDKQ0KPiArCQkJZXhmYXRfZnJlZV9iZW5pZ25fc2Vjb25kYXJ5X2NsdXN0
ZXJzKGlub2RlLCBlcCk7DQo+ICsNCg0KT25seSB2ZW5kb3IgYWxsb2NhdGlvbiBlbnRyeSgweEUx
KSBoYXZlIGFzc29jaWF0ZWQgY2x1c3RlciBhbGxvY2F0aW9ucywgdmVuZG9yIGV4dGVuc2lvbiBl
bnRyeSgweEUwKSBkbyBub3QgaGF2ZSBhc3NvY2lhdGVkIGNsdXN0ZXIgYWxsb2NhdGlvbnMuDQo=
