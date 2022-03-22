Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460504E494C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 23:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbiCVWqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 18:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiCVWqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:46:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC94558B;
        Tue, 22 Mar 2022 15:45:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MKxfah009756;
        Tue, 22 Mar 2022 22:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=IiRmBsJ/ioc9fqW7EjtsNPzfuBiSkg11hCNt9tw3ynk=;
 b=BfqI3/V5F/MHQh3TV3ZJOhQDKHm6ibt4L93h4BRls5YrWr6yAt6PacHz3LxRBX6mI1Cv
 jvwA+vbTTacpBuisaIz/tDHnNTAU18fGiPCe8KmoOoXiCow87BZpPjCTk0BZMwCjk76J
 CmojleqEDTWIr0L56l7YJeWfVJ9DDKBWD9ORQ+ySnuJZw8PfpcB+n2c8R3XbOaw0MrSf
 tC1kZmEJoYDde7jGpCBLonu11N+QxnlEpl9WBsutOcAkuzwjYgERoSEy/1iaN8zhcSom
 0/O0+Owo26KkXC9iqNcEFeYwPD+XuoiTVqiDTnj2YYd67MtHwGuRbZE2mTGeL2RNN7xv 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew7qt81g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 22:45:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22MMRF57124098;
        Tue, 22 Mar 2022 22:45:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 3exawhw64a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 22:45:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFSwQoUDtXGAzYl/OwzkpSnZ9fWbMb2KNYGIdqgU27E+Pikj8a2V1Gl1gIV2PVJdG+7vKH2uTe1YlDHhtlYp7lBGH1XveEPEg6wggDBkqHKVo4ta1Ib7qlho+aEpgEZubexuN82kIyOxcfX2OxaI9LYQ0HOkuSj9E99tGrthCwpszJXSHA1jPwnMCf78n3ARu2u1eGdH1YytYJlafJ6o76/jRPLgOIasX5zUTz3Zmj9CYXtV0Y9DcXA3qLOiLE7+HFVvPn/4siDYU85j+cWTnBC0pEcnL/DyK8yOH4J/2He42UxK9jcMZekREkXGekz7jMr1yQ+z51jwjCgvhFFSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiRmBsJ/ioc9fqW7EjtsNPzfuBiSkg11hCNt9tw3ynk=;
 b=BaeNCQWta7TVNqzXB0wABgbAQibM6YRYXOW1NfPgVmEVvxL5D+qTg7tvsG3HBPvbe7F7GWmTcttnv36hhKWOj3BrHQOiID2GYnp9a0auM75lllcOKCxWV+zeI8OiypBaSZgRInazN0LpJxYUJV/NVd8dn7ivDAjuKBsMiZ2/LZBZbfldPlnXzdM9NPEzZkt3aOK8Tyn83PU5rzxva1FeTT4yKJ3eHi6naCkOg521v+FhECwqgZXzFb/2fKWEHITUD2vFR/9N9hAjLSrxBtsxDRh0TmAbxQrBrG2FOrujRHNISkLwjGyBi7EBqhfw8z60rUxpiFigReAQDeEVvohIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiRmBsJ/ioc9fqW7EjtsNPzfuBiSkg11hCNt9tw3ynk=;
 b=xtpQsEepuS8sFg4m3dfD3MXVRhChqGBxV9u0AyRcB7ZE7+nUNyIZFVnFN7Udmm21TLBYoyUC8fCsrnkKq9gfAqdMdSxIlaa8m2kA9rzdWklrlLS0Z67rnu8waETM1uQ0AzdEYzi6PDtkY1BH2fOFbVmepQaUnmqig+1LQSlfqCs=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB3962.namprd10.prod.outlook.com (2603:10b6:5:1fb::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 22:45:01 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%7]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 22:45:01 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Topic: [PATCH v6 3/6] mce: fix set_mce_nospec to always unmap the whole
 page
Thread-Index: AQHYO1qo97Ua/3iJEUWuhawaHD7cIazLG0oAgADq7oA=
Date:   Tue, 22 Mar 2022 22:45:01 +0000
Message-ID: <fb1ca254-3e7d-0931-2bfa-8f7f27b7d4fd@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-4-jane.chu@oracle.com>
 <YjmMWvDRUHE08T+a@infradead.org>
In-Reply-To: <YjmMWvDRUHE08T+a@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87a385aa-e96a-4b26-5021-08da0c5599d1
x-ms-traffictypediagnostic: DM6PR10MB3962:EE_
x-microsoft-antispam-prvs: <DM6PR10MB39625EFA02DE512E3B6F170FF3179@DM6PR10MB3962.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETSYTVFdjesuLr8GHCuPkIqMwftlVN8zHgQtFRUYdhsZtWkkQPM2Tl2J+ZY+HH2V2QTJJ3TBKxssDQ1ge+K8YMd/rrpq7/SG0ecRL47NHfk7M0Xlh78KaqKauQWAPBoErIiMXI5fyxzHaBQzL1yUTshKs80pZL7UDmC+2NugYp9B67TMzSIx8k2/9PCMJimzw/z04Noyk1TEVXlT5hNxE5b/Rq2JA9mkbi649CIeOBrl44vF2fX55U6j8JcZobBDWQTbfMUkEXc2Hu9TtdVy7zsKn39+SyGLHRyG3faUvSmVWsgnDd/5NbBYzi8GMxGGhzGTVYbtdn12hOkY4RGHmHcO+0s1v4V55mMJWdijtdWj8W5yKf972P5UkEBpUeqe8IU9k/TJFVJ9YRsRin6ukfnzFiMGvrjiJzimwlipbc77thK72dzkZq4d9dnDVv4mZSgaEurIIqw0sQcmAHvKBdHpC3hR6VXn/Cm20h72JGxF7i+cw4paAquYFqrLX5j1tgGs4UW4WS9mSWYzaX4REnZi6qdtGATnO89vS6IBHyWQn7s2yRgM9EjsvBHsKYOY8nqdEoOj/lCyqAqt6EhuSduvivNVve+D4zk1AwiJJSgB1NBMMUHnnEkZo+ys02Ru18j5KRT0fHOGAwJv4bftL7vG5lxolBWCWGfwZHVz5mfQ7qYUaGBb9hPWSlJPTUFGquk58s7y1zqlo+wxjakZJZR/UZJjTNLmqwlwOEFjs5fKFijlJV/cXu8SG0BFe6cp6FueRpxQmKwdVFdlJEpegGRdeWsFzdSLuRfBI5G1XNF9+i40K4+Y+sir+bxVEO0FJA8MCIRBRO7MfMLG98MLDDUiY1dCHdA+22CGEKQDx08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(54906003)(6916009)(38070700005)(2616005)(316002)(66946007)(26005)(186003)(76116006)(8676002)(66556008)(86362001)(66446008)(64756008)(31696002)(4326008)(66476007)(71200400001)(2906002)(508600001)(5660300002)(966005)(6486002)(6512007)(122000001)(53546011)(6506007)(8936002)(7416002)(4744005)(31686004)(36756003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3F5OXB5VEhRV1d4Z2NhNVJBMUN0K2twcms0Z2ViVEp6RU1QMGh1MlRsMW1v?=
 =?utf-8?B?K3VVZTNNRXR3NjVsa2lyVWlWY2lBQ1htSXI3bURSRE5QWUNjdGR4dGR2MWtE?=
 =?utf-8?B?eS9vODIyWXh2UndEZ2FuN3VGd1F0Q0FsRHdoU2J6TjFnaDZKcHViUENNcXVp?=
 =?utf-8?B?SWhIaTdzSEpxYnIreDhmbk9SV2x5Y1lwT0Y3b09xbktoMHlJZ0xDZy96N1d1?=
 =?utf-8?B?L0ZESk53b0NaZmlNYk14QlQrUVg0QTlIdWhnclJid09qY1hQWWVPQzVCOXZi?=
 =?utf-8?B?eklsdG1tYVdWeXVkYzRvZzljUXN5RzJpeWlXT25TcDJDZDdqYUxCOW8rTndJ?=
 =?utf-8?B?VFk2RVRIOEozRzBhUllTRGJqNUhxRW9CTVZPK2I3U0NNNVVrbENUblZ1VE1j?=
 =?utf-8?B?eFRUdWlhSkRwQWhpU2Jucmw0WWZJQkxFd2RkTjU0WUVnQTdFOEtZK0FwbDhk?=
 =?utf-8?B?RHJnQXNHalcwWi9jZ2habnhldjUzODEzdE0zeDFneUpDTTh6NEJhMHVGV2lN?=
 =?utf-8?B?WGh3YkxGeWVOVy9ML3ZmVnJ3akZNQ0JManJPWDN2ejBkS3BXMzMrY3FaY0xP?=
 =?utf-8?B?NHQyRGZ2RHh5NkIxaGI0UmpzUmJNT2h1UzZzbHViQ1RwMTl6bjBnRFM5MFBw?=
 =?utf-8?B?Q205NHY2Z01KMGhaNlhQV2VUVFE2Nmp6Nk9nUk1ScThPM1RMZWJGOEtva3ll?=
 =?utf-8?B?WHovcGVGNkYvdTZTei9OM2UvQjQzN29UQnVRU2l3czVzbUIyUnV6N0tsa3Vp?=
 =?utf-8?B?UE5iZkhzWWFsRHJtQ01iZ3BvNlp5Y2JGNGJTSE5heEJJZjJ4MkxEVFFrdlBX?=
 =?utf-8?B?Z0dUYTNsV3ZNUXpHTldyeXNaNUhWTGEvVGJnQ0lQTTlwZDZWS3I2OVUyMU1C?=
 =?utf-8?B?eDdFaFhTTG10bkxSVkNESkxJVm9nSWJBN0VYNkxtNDRSUENkOWZtWGlHU2lo?=
 =?utf-8?B?MjNqKzgyWUZTcTBJalQrblIwYVQzWVFxUHdIclNMb2RKbW9tRlkwcjVwdlNp?=
 =?utf-8?B?MXhsaUE5SDlmYVZIUnRUUTdzTktNYzFKL0Q5dENScDVvRGpOQWxnYk43elFp?=
 =?utf-8?B?czFnalM4bCtGaUNmUFVkbW80SW8wZ0xJR09WSXM5UDZ1REhGM1Y0a1RScGhU?=
 =?utf-8?B?MUxmeWc4UVhyNWFrS1NXRVkwbktjZ0xMOUR6Nnl0M3JkcFpxMWFVN0dXL1lS?=
 =?utf-8?B?U1hJbmgvTlhCUU80SmdEL1VOVWV4ZVRxTjBEUmNqUXRvd0F5dlpUNkVyS3FG?=
 =?utf-8?B?T3F4TVBoT25USUJLbTR4S1NIUFR1dzVrRnU5QUxIWGVEUFQ3MmlDcjRSdFhp?=
 =?utf-8?B?Y1BFYkpodGFadjlPaHJWQUs1ZDdONk1ZSmQyVmRQT09DR0RNK3p5RFNYUVNp?=
 =?utf-8?B?UEdwa2lkM0QwOVhOTTV5azBjRzZzdzZkOFgzcEFaYWZwdDVMQTFoSm9QZkZw?=
 =?utf-8?B?UndreGFPUm5xakhtSEdQQ25JK0duL1VFMWQ0U2FnV2krL0ZnY2tGd08yVjc1?=
 =?utf-8?B?RGhtWWJrMzNUb0hNL3Aremc1NUhJems2RUJVbWRyMEZTRFlJdGV6bkdjQXBZ?=
 =?utf-8?B?VE9tOFl6ajgvODQ1UXlqdmNWNXN0WDV1N1BYSm8vRlNKSVFDcnpqbXRWNFVy?=
 =?utf-8?B?K3lOMmxVU3U5U0RWeGNQZG9qZEJPTzVHaDRzQlB1NFl6R2pzNVZVelBJOSs4?=
 =?utf-8?B?Ujl5c0g0aVRhblgzL0E3QXY5M005UjZUQjd1L3NQWTFtdGQ4WDRITDBZYlNF?=
 =?utf-8?B?SjRsUHBEeEgvdGtBOFlDMHhkdE1XT0NnajlrN25zbDlrb2lQWkJmaWowQlVV?=
 =?utf-8?B?RHgyUENUTlc1TTJ4NVN2eUlzU3RUY3EvMFhrdkVRM1Izb1lWSnJFMjJCZENY?=
 =?utf-8?B?UzdCdGFVb0ZoOTUvcGYyU1RET1MxOXVlbk1BMDJKQXdKR1FZS3pCdDhWNVpW?=
 =?utf-8?Q?cQw2pxNG5WXY3+uDJTxugr753LP8qjUP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7994CE8F9771B646B18C620474D3926F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a385aa-e96a-4b26-5021-08da0c5599d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 22:45:01.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfYfq+vqtxoP83FsFQtmHslbIiVfyv+YCtoJWJ1wE9rRAv6lPt2jskstaIPRyVP5JC2QtBmMqnrlpTPj8E/Kyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3962
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=973 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220113
X-Proofpoint-GUID: jghG1jYHWYVY4M8JLUBdUXEtirWA9OUL
X-Proofpoint-ORIG-GUID: jghG1jYHWYVY4M8JLUBdUXEtirWA9OUL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yMi8yMDIyIDE6NDQgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBTYXQs
IE1hciAxOSwgMjAyMiBhdCAxMjoyODozMEFNIC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4+IE1h
cmsgcG9pc29uZWQgcGFnZSBhcyBub3QgcHJlc2VudCwgYW5kIHRvIHJldmVyc2UgdGhlICducCcg
ZWZmZWN0LA0KPj4gcmVzdGF0ZSB0aGUgX1BBR0VfUFJFU0VOVCBiaXQuIFBsZWFzZSByZWZlciB0
byBkaXNjdXNzaW9ucyBoZXJlIGZvcg0KPj4gcmVhc29uIGJlaGluZCB0aGUgZGVjaXNpb24uDQo+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FQY3l2NGhyWFBiMXRBU0JaVWctR2dkVnMw
T09GS1hNWExpSG1rdGdfa0ZpN1lCTXlRQG1haWwuZ21haWwuY29tLw0KPiANCj4gSSB0aGluayBp
dCB3b3VsZCBiZSBnb29kIHRvIHN1bW1hcml6ZSB0aGUgY29uY2x1c2lvbiBoZXJlIGluc3RlYWQg
b2YNCj4ganVzdCBsaW5raW5nIHRvIGl0Lg0KDQpTdXJlLCB3aWxsIGRvLg0KDQo+IA0KPj4gK3N0
YXRpYyBpbnQgX3NldF9tZW1vcnlfcHJlc2VudCh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBudW1w
YWdlcykNCj4+ICt7DQo+PiArCXJldHVybiBjaGFuZ2VfcGFnZV9hdHRyX3NldCgmYWRkciwgbnVt
cGFnZXMsIF9fcGdwcm90KF9QQUdFX1BSRVNFTlQpLCAwKTsNCj4+ICt9DQo+IA0KPiBXaGF0IGlz
IHRoZSBwb2ludCBvZiB0aGlzIHRyaXZpYWwgaGVscGVyIHdpdGggYSBzaW5nbGUgY2FsbGVyPw0K
PiANCg0KT2theSwgd2lsbCByZW1vdmUgdGhlIGhlbHBlci4NCg0KdGhhbmtzIQ0KLWphbmUNCg0K
DQo=
