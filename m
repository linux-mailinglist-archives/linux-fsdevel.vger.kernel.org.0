Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F8E4E497B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 00:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiCVXHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 19:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiCVXHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:07:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3466EB1A;
        Tue, 22 Mar 2022 16:05:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MKxOl0031698;
        Tue, 22 Mar 2022 23:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TDJFmhs3KmMCaBSNALEPjWjikt1qCVHBT8KNIpBMeSM=;
 b=vZ98vYh04YmCiUjDWub+dkKUlSUb6Xu0pSU2emC9DtzQvC2nYcfZXQL7QXv6OwHWA8ZK
 r91MJogx2/CLqxxrzSoyavD4PTDforetHd3mZqIzxaIaJbZ518w5iWS9RC/eTlpC5ldv
 wYerPmiXeJEGttp83R5gZzbb99mw1YpiS9UpmE1vOjvv2sjeGV9cTB+VGXACrx5SU4OI
 Qd450Np2sJ4XcALu2OFDOswRdmws7GMvrsHcwQSmSuq00jZrcV3ohlQ0u9z5MoSxYGam
 /BX2hP9YvnIgI7MvACFRAvdDJ4gUSxsCCnrz6bw2bIDh0HMs0Wjr/22Y747UhaIfgVbP /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew6ss7wyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 23:05:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22MN0MwM032944;
        Tue, 22 Mar 2022 23:05:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by aserp3020.oracle.com with ESMTP id 3ew701d0kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 23:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/2+ooHAFuV40ThXPwE0haaNRBROUNSyL9ZbkixuusztPchTq1jp3TYKS18kZlUlFTFVcmzWad7lphidCeATs8rIZQxTKM5IDjrM9k/YnE6iigOiC3yhk2OtE0YUDTWcyPYWHZwg4P7YvdKVPc6ngHPSsVgrWgO5nnQJ7oj3MB/nBOyTf6NCtCdtMCSVwjtRzfXspu4x11lfnapfLEwbx/s6T38TINQyONe6hycnaRAzxqlSh+kDXGMRrBkZv3DQShAPwz4uEAw1WlbJfPzIOg+4sqqnFuMq4NlhIwEXO+TQyL0YdmzEbjjO7sHe/15q2647k0iC0fDWazvszlQiLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDJFmhs3KmMCaBSNALEPjWjikt1qCVHBT8KNIpBMeSM=;
 b=DykNGAy5ijITc5ZFKcS5a7n0FLTsMUj4iFu89D2urdbqOuMLeYrpAkOJdQKVqMvJ3YdVCodirfYoSq7svnS2beUB8p4YTUTEyRRkTiJ1w1BImM7bvczr2IsIfKZ01YGAtFQi3FrGRysYouW55raVCv8B4lFeHA6OswHfyHJR03co73ct8fTYTjT6Bf2K7Jj6tbCAhZZHy+LzzS7zN8hlDZSkMdLyo2XwhEi4IO+JxXMl9jOdN+3/CZiI3GfJw3d4hXca+txRiS2RMN1sa9pNWlANlGha1WXsn4FPDdxcO7RRtmY2dgCTBS3dpBg6ZZoeXvxAeixurHl+kEDTC8Z9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDJFmhs3KmMCaBSNALEPjWjikt1qCVHBT8KNIpBMeSM=;
 b=CtnFi5n9h25i56737Ruu31bfFmPdAGJ9YOb+AlTPx6sRXqLwBCIc1znJNMJ40sdSHzTBTFz/+FngYzkq/fInemPc/IW7FD5ux0r/i/IAtNljY0sSV2E26SDnC48/Aq8Ijww9zBT1H6VgsQ7fDSXf7+Uk8KwnCVJcjol+epbcUWY=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MW5PR10MB5850.namprd10.prod.outlook.com (2603:10b6:303:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 23:05:10 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%7]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 23:05:09 +0000
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
Subject: Re: [PATCH v6 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Topic: [PATCH v6 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Thread-Index: AQHYO1qr0XYuk2dPyEaDqgStF1AJhKzLIC0AgADrq4A=
Date:   Tue, 22 Mar 2022 23:05:09 +0000
Message-ID: <3dabd58b-70f2-12af-419f-a7dfc07fbb1c@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-5-jane.chu@oracle.com>
 <YjmQdJdOWUr2IYIP@infradead.org>
In-Reply-To: <YjmQdJdOWUr2IYIP@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 406b147d-d0de-4949-5d2f-08da0c5869e3
x-ms-traffictypediagnostic: MW5PR10MB5850:EE_
x-microsoft-antispam-prvs: <MW5PR10MB5850BBAD3C4C06E0C2902F04F3179@MW5PR10MB5850.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b7+226ffVe0zmPNBms6v1ScYF/bbHWzh9IUTdeE86vpRD3DX/H7dcQZLEimA0oYNZuqMY7+4Mqmy9GpYRjIM0LA0y2URIdgD9FMH+pPkS8FEkOb4NSSQ//Hl1++lwKTIiBbXI0/HVNq7k8s6R8yRzzbZLQ+U/f5a6Tb6ok1eGoZdhcYBYJTckxJgK/VdQKptMdBNMiXqH0RFfI32+3sYNVZBQqR+VEeMDBrrA3C5YN6ILwmR7o2TKlifv86CoSH6RcMMtn2uSwr/iUkRlY9RxqRq8RB13WuP/MysHvX7KB2rRDgJ87SYcawokrdq/w+0sYqWuUonFmxJ0wzKz33Oxtu8xZEGxMrhVOxNXL3yb/zX7t0JlQty82rXcmdbPkzNeBgYJw+dl3xoAXhFnWjb7Re4Ql5keXsHnCXC+YiQEJeW/0nlwyKPOiDfgOcoy9HPX3Pjo6ayCU5Ij7vS2NdrJsAawaevS+zzC6vsq7sIPkeB9j/vRrCbOfry/cAd/yP2D1LkKiHWaEbgC2FOEweFIuuTU9DYSsYVnmdf7+lBHYwCodZhFZs8oxVzhNzrd1WPSn8rBF/a8deiZVYCHJTTyBsbprUhle5KSb3eM0jcI820jFJpKscva2n4C7ePdHxn9MweFOXJRzIATs/CKehKIu7cfSP5/XZqPrnOfjDYlmuGdb2+fsIVIaf1GXwSrimBArKp9lF0s1sIW2+aNuYUve/5EeH5hjH/Ud1jNhAximAzXbbwqaRBKLdWBloJ43r1fFQoKT1XNdfysegv355KgEvpglhxoCyiPGKqWZ1InuzuAPpQImyC967QuPvyoY1R+8f7caMb/YNldbmExNu9v05APIXd/yPxoysEXgVmXEryvSmmTNGbFx2VbWe0d2OrtjVyAdL9J6Z9n/pGowPHxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(38070700005)(54906003)(44832011)(7416002)(71200400001)(8676002)(508600001)(966005)(186003)(8936002)(26005)(2906002)(83380400001)(31686004)(2616005)(36756003)(5660300002)(122000001)(64756008)(4326008)(76116006)(91956017)(86362001)(31696002)(6512007)(38100700002)(6486002)(66476007)(6506007)(66946007)(66556008)(66446008)(53546011)(142923001)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWFIUU9oVGRSMmdQbGphQVdJMFhUajltR0IwajNKbWtOeXRnUFNnMWpEZUpY?=
 =?utf-8?B?RWlRN256c052THJZSWlWeHpXNUNxOTFRL04xbWtqa3BLU2dGc2hWQXB1VjNV?=
 =?utf-8?B?ZVI5RzN5cloxcGtwWFBIVGY1TEQ4V2JUcHA1TWgwRm9ZVEkwdU9XTExudndL?=
 =?utf-8?B?SDNXVldiaTlsSjBrcENmOWROU25RMGl3MWJLaUQycjhqNHp3dVUzTWFxb3E1?=
 =?utf-8?B?a3hHTDZXRXNDSHpnT05VdDBHZXJCR04vWnJuRUc0WFZsOUlROWp5bWJidlN5?=
 =?utf-8?B?SEtCN0xWODZQbldDcTU3NzdjaGxhaWRCc1JaNFdyNDBvaTBQNytxOE41Q0Fr?=
 =?utf-8?B?cmx3R3F5cUhiaVVIaFZoYzZkT1hURGlJREdDWEluQk0zNXRudGVDdk5iOXFR?=
 =?utf-8?B?aW5BcmcwZWpUQ0RBSlZ0NDR2NEtmTzZ6N3ZqcWhjOFdzd0FEVWsvL2VnSFhz?=
 =?utf-8?B?RzFkdzZhVG4ybjdMUlVWa1Vkc29qT2JxMnZiWDRuNGZSand2V1piOXZmaWpO?=
 =?utf-8?B?UXJqQWQ5Unk5OXpNRjNPb00xRy9mVVFLb2xYbHhzZlhrb1NBTEFudjlBNTdD?=
 =?utf-8?B?OFB6TXJwVzRtSGhHRy9yWDhzL0E2THhBU00zYXM0NlVydUxPcmZDVnpXZXVY?=
 =?utf-8?B?dk0rVUpWbGxzRTJYNktCbWNzVFhNK3JnbFRLRHphVDFuam9SZEs2RnZtT04z?=
 =?utf-8?B?aVNteXFMZkV3OExhVkwvZVFkUmpTSXJYR0w0eHl5SXB4NTdpT1hCUEZNOEha?=
 =?utf-8?B?dmRFNFBaWW5rZUFodUx5SU91akY2a0xnVzNSSTdnb01DTGN5aFpoclNNblYw?=
 =?utf-8?B?SnRodkpzM0JHQXZ1N0NNNW1NTTVOUVNMRUdQZkpiZVpmZFNqRGMzVEQvTHVk?=
 =?utf-8?B?QmNQaDRBcUQwSDY1NkQrU0lzODVqSzZTYXVuaXJFYzM4SEFXM1JuRmF3VzJZ?=
 =?utf-8?B?M3R1UG1zbXdHMEE2TkcrRmc4cjNpNURQQjZqbWZXQ0RaU1BxR1ExKy9IN216?=
 =?utf-8?B?OTNxaTZvQytDMUtScC9qaC8rU0xCK0Q4bE9zQkVqM3pZNDNhSkMwL2Jqczd3?=
 =?utf-8?B?LzB2NnhDWStHa2lLTTRvaWc5WGtiblhhWTVleUpHeDlOaXlDMDhwTVJvLzdI?=
 =?utf-8?B?TXZ5KzRhdEw0bmhTY0dVUHJ5cXQxcnBzQXQzSEJ1NjA5UDdkV1VZMnhhbXVa?=
 =?utf-8?B?SHZpK1o5NktkdWhkbndDdW4xYWlqUWp2WHdNZ3dkQkxNdzI5NFhpU21IeTRB?=
 =?utf-8?B?VmxhbjJTcTBNaHJiWUhSYW4vWkFYenBsNmFsT1dXMU5tbXBkWWZQUTdHTFJO?=
 =?utf-8?B?K3lIdzJFUXhGanNhbHF1U2puaG9RT202Tmwrb04rTE9OUWw4M0U1Ty8reE41?=
 =?utf-8?B?Umw1MGlXN3dnYjArUHMxRWMrNDh3bGl0Si8xaUxmalRYQnNvWFJHcUFrTzVP?=
 =?utf-8?B?NlFtd2FmQVNYd2tzZTRMYU5OcjBadlQ0QTJuTzU0Zm1DY0I2YWVlYlVSS0pY?=
 =?utf-8?B?TkxndjZhMFk2aHQrWWVoWDc3UTl1amhkZGd5RjBmSkVnd1FLVnFUaEhtNHhj?=
 =?utf-8?B?eUsyNGl2MEYyTXNCOE1UclE5N0hxa0FUTks3aG5McWgvbzRjendqQmtob0NL?=
 =?utf-8?B?d2VKTU5lZnVsMUIvU2pKK3ZZSlpYSUd2blFvZVF5cXZsVXBkOTh3aXlGREZv?=
 =?utf-8?B?WjRMRjE0Nkk1a1lQY1NhUkZRUkZ1MHpZS0lzdFliVFUrVEdrVVVZZlJ0eWtm?=
 =?utf-8?B?ck1TTklwd1FhQzM4Z1d2Tjdsc1ppVXdtSHBQckw4QUNPVy9nVmEzcGdla25V?=
 =?utf-8?B?cTNJRGlGQ25QMTNnbEgzYWl0M2RXSXhpVnk4cXV1K0pXT2FDbkh1NmcxMFlw?=
 =?utf-8?B?aGtqZjJzMGo0RDlYMlE0WERXR1YrQ2ZIRFpBb3kvbWxUOE5DOUp6akFDS3hj?=
 =?utf-8?Q?cxB685WVmab4tNFUhGFK6yu+q2SXpcSr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F7728E77F62C744B1FAD3F31A66C80D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406b147d-d0de-4949-5d2f-08da0c5869e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 23:05:09.8728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FkKlthJ90ugHH7KPose51quhfw0uNbH6MO/SW2dgXu+jf/WgHcFfttJ7fzxVUF5bhCd5SWF0edEUYe3mRKeLmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203220115
X-Proofpoint-ORIG-GUID: 6NbL5qVq9lelEGBPcm11rFV6LqMjNJbI
X-Proofpoint-GUID: 6NbL5qVq9lelEGBPcm11rFV6LqMjNJbI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yMi8yMDIyIDI6MDEgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBTYXQs
IE1hciAxOSwgMjAyMiBhdCAxMjoyODozMUFNIC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4+IElu
dHJvZHVjZSBEQVhfUkVDT1ZFUlkgZmxhZyB0byBkYXhfZGlyZWN0X2FjY2VzcygpLiBUaGUgZmxh
ZyBpcw0KPj4gbm90IHNldCBieSBkZWZhdWx0IGluIGRheF9kaXJlY3RfYWNjZXNzKCkgc3VjaCB0
aGF0IHRoZSBoZWxwZXINCj4+IGRvZXMgbm90IHRyYW5zbGF0ZSBhIHBtZW0gcmFuZ2UgdG8ga2Vy
bmVsIHZpcnR1YWwgYWRkcmVzcyBpZiB0aGUNCj4+IHJhbmdlIGNvbnRhaW5zIHVuY29ycmVjdGFi
bGUgZXJyb3JzLiAgV2hlbiB0aGUgZmxhZyBpcyBzZXQsDQo+PiB0aGUgaGVscGVyIGlnbm9yZXMg
dGhlIFVFcyBhbmQgcmV0dXJuIGtlcm5lbCB2aXJ0dWFsIGFkZGVyc3Mgc28NCj4+IHRoYXQgdGhl
IGNhbGxlciBtYXkgZ2V0IG9uIHdpdGggZGF0YSByZWNvdmVyeSB2aWEgd3JpdGUuDQo+IA0KPiBU
aGlzIERBWF9SRUNPVkVSWSBkb2Vzbid0IGFjdHVhbGx5IHNlZW0gdG8gYmUgdXNlZCBhbnl3aGVy
ZSBoZXJlIG9yDQo+IGluIHRoZSBzdWJzZXF1ZW50IHBhdGNoZXMuICBEaWQgSSBtaXNzIHNvbWV0
aGluZz8NCg0KZGF4X2lvbWFwX2l0ZXIoKSB1c2VzIHRoZSBmbGFnIGluIHRoZSBzYW1lIHBhdGNo
LA0KKyAgICAgICAgICAgICAgIGlmICgobWFwX2xlbiA9PSAtRUlPKSAmJiAoaW92X2l0ZXJfcnco
aXRlcikgPT0gV1JJVEUpKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBmbGFncyB8PSBEQVhf
UkVDT1ZFUlk7DQorICAgICAgICAgICAgICAgICAgICAgICBtYXBfbGVuID0gZGF4X2RpcmVjdF9h
Y2Nlc3MoZGF4X2RldiwgcGdvZmYsIG5ycGcsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBmbGFncywgJmthZGRyLCBOVUxMKTsNCg0KDQo+IA0KPj4gQWxz
byBpbnRyb2R1Y2UgYSBuZXcgZGV2X3BhZ2VtYXBfb3BzIC5yZWNvdmVyeV93cml0ZSBmdW5jdGlv
bi4NCj4+IFRoZSBmdW5jdGlvbiBpcyBhcHBsaWNhYmxlIHRvIEZTREFYIGRldmljZSBvbmx5LiBU
aGUgZGV2aWNlDQo+PiBwYWdlIGJhY2tlbmQgZHJpdmVyIHByb3ZpZGVzIC5yZWNvdmVyeV93cml0
ZSBmdW5jdGlvbiBpZiB0aGUNCj4+IGRldmljZSBoYXMgdW5kZXJseWluZyBtZWNoYW5pc20gdG8g
Y2xlYXIgdGhlIHVuY29ycmVjdGFibGUNCj4+IGVycm9ycyBvbiB0aGUgZmx5Lg0KPiANCj4gV2h5
IGlzIHRoaXMgbm90IGluIHN0cnVjdCBkYXhfb3BlcmF0aW9ucz8NCg0KUGVyIERhbidzIGNvbW1l
bnRzIHRvIHRoZSB2NSBzZXJpZXMsIGFkZGluZyAucmVjb3Zlcnlfd3JpdGUgdG8NCmRheF9vcGVy
YXRpb25zIGNhdXNlcyBhIG51bWJlciBvZiB0cml2aWFsIGRtIHRhcmdldHMgY2hhbmdlcy4NCkRh
biBzdWdnZXN0ZWQgdGhhdCBhZGRpbmcgLnJlY292ZXJ5X3dyaXRlIHRvIHBhZ2VtYXBfb3BzIGNv
dWxkDQpjdXQgc2hvcnQgdGhlIGxvZ2lzdGljcyBvZiBmaWd1cmluZyBvdXQgd2hldGhlciB0aGUg
ZHJpdmVyIGJhY2tpbmcNCnVwIGEgcGFnZSBpcyBpbmRlZWQgY2FwYWJsZSBvZiBjbGVhcmluZyBw
b2lzb24uIFBsZWFzZSBzZWUNCmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIyLzIvNC8zMQ0KDQo+
IA0KPj4gICANCj4+ICtzaXplX3QgZGF4X3JlY292ZXJ5X3dyaXRlKHN0cnVjdCBkYXhfZGV2aWNl
ICpkYXhfZGV2LCBwZ29mZl90IHBnb2ZmLA0KPj4gKwkJdm9pZCAqYWRkciwgc2l6ZV90IGJ5dGVz
LCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpDQo+PiArew0KPj4gKwlzdHJ1Y3QgZGV2X3BhZ2VtYXAg
KnBnbWFwID0gZGF4X2Rldi0+cGdtYXA7DQo+PiArDQo+PiArCWlmICghcGdtYXAgfHwgIXBnbWFw
LT5vcHMtPnJlY292ZXJ5X3dyaXRlKQ0KPj4gKwkJcmV0dXJuIC1FSU87DQo+PiArCXJldHVybiBw
Z21hcC0+b3BzLT5yZWNvdmVyeV93cml0ZShwZ21hcCwgcGdvZmYsIGFkZHIsIGJ5dGVzLA0KPj4g
KwkJCQkodm9pZCAqKWl0ZXIpOw0KPiANCj4gTm8gbmVlZCB0byBjYXN0IGEgdHlwZSBwb2ludGVy
IHRvIGEgdm9pZCBwb2ludGVyLiAgQnV0IG1vcmUgaW1wb3J0YW50bHkNCj4gbG9zaW5nIHRoZSB0
eXBlIGluZm9ybWF0aW9uIGhlcmUgYW5kIHBhc3NpbmcgaXQgYXMgdm9pZCBzZWVtcyB2ZXJ5DQo+
IHdyb25nLg0KDQppbmNsdWRlL2xpbnV4L21lbXJlbWFwLmggZG9lc24ndCBrbm93IHN0cnVjdCBp
b3ZfaXRlciB3aGljaCBpcyBkZWZpbmVkIA0KaW4gaW5jbHVkZS9saW51eC91aW8uaCwgIHdvdWxk
IHlvdSBwcmVmZXIgdG8gYWRkaW5nIGluY2x1ZGUvbGludXgvdWlvLmggDQp0byBpbmNsdWRlL2xp
bnV4L21lbXJlbWFwLmggPw0KDQo+IA0KPj4gK3N0YXRpYyBzaXplX3QgcG1lbV9yZWNvdmVyeV93
cml0ZShzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwLCBwZ29mZl90IHBnb2ZmLA0KPj4gKwkJdm9p
ZCAqYWRkciwgc2l6ZV90IGJ5dGVzLCB2b2lkICppdGVyKQ0KPj4gK3sNCj4+ICsJc3RydWN0IHBt
ZW1fZGV2aWNlICpwbWVtID0gcGdtYXAtPm93bmVyOw0KPj4gKw0KPj4gKwlkZXZfd2FybihwbWVt
LT5iYi5kZXYsICIlczogbm90IHlldCBpbXBsZW1lbnRlZFxuIiwgX19mdW5jX18pOw0KPj4gKw0K
Pj4gKwkvKiBYWFggbW9yZSBsYXRlciAqLw0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+IA0KPiBU
aGlzIHNodWxkIG5vdCBiZSBhZGRlZCBoZXJlIC0gdGhlIGNvcmUgY29kZSBjYW4gY29wZSB3aXRo
IGEgTlVMTA0KPiBtZXRob2QganVzdCBmaW5lLg0KDQpPa2F5LCB3aWxsIHJlbW92ZSB0aGUgWFhY
IGxpbmUuDQoNCj4gDQo+PiArCQlyZWNvdiA9IDA7DQo+PiArCQlmbGFncyA9IDA7DQo+PiArCQlu
cnBnID0gUEhZU19QRk4oc2l6ZSk7DQo+IA0KPiBQbGVhc2Ugc3BlbGwgb3V0IHRoZSB3b3Jkcy4g
IFRoZSByZWNvdmVyeSBmbGFnIGNhbiBhbHNvIGJlDQo+IGEgYm9vbCB0byBtYWtlIHRoZSBjb2Rl
IG1vcmUgcmVhZGFibGUuDQoNClN1cmUuDQoNCj4gDQo+PiArCQltYXBfbGVuID0gZGF4X2RpcmVj
dF9hY2Nlc3MoZGF4X2RldiwgcGdvZmYsIG5ycGcsIGZsYWdzLA0KPj4gKwkJCQkJJmthZGRyLCBO
VUxMKTsNCj4+ICsJCWlmICgobWFwX2xlbiA9PSAtRUlPKSAmJiAoaW92X2l0ZXJfcncoaXRlcikg
PT0gV1JJVEUpKSB7DQo+IA0KPiBObyBuZWVkIGZvciB0aGUgaW5uZXIgYnJhY2VzLg0KDQpPa2F5
Lg0KDQo+IA0KPj4gKwkJCWZsYWdzIHw9IERBWF9SRUNPVkVSWTsNCj4+ICsJCQltYXBfbGVuID0g
ZGF4X2RpcmVjdF9hY2Nlc3MoZGF4X2RldiwgcGdvZmYsIG5ycGcsDQo+PiArCQkJCQkJZmxhZ3Ms
ICZrYWRkciwgTlVMTCk7DQo+IA0KPiBBbmQgbm9uZWVkIGZvciB0aGUgZmxhZ3MgdmFyaWFibGUg
YXQgYWxsIHJlYWxseS4NCg0KT2theS4NCj4gDQo+PiAgIAkJCXhmZXIgPSBkYXhfY29weV9mcm9t
X2l0ZXIoZGF4X2RldiwgcGdvZmYsIGthZGRyLA0KPj4gICAJCQkJCW1hcF9sZW4sIGl0ZXIpOw0K
Pj4gICAJCWVsc2UNCj4+IEBAIC0xMjcxLDYgKzEyODYsMTEgQEAgc3RhdGljIGxvZmZfdCBkYXhf
aW9tYXBfaXRlcihjb25zdCBzdHJ1Y3QgaW9tYXBfaXRlciAqaW9taSwNCj4+ICAgCQlsZW5ndGgg
LT0geGZlcjsNCj4+ICAgCQlkb25lICs9IHhmZXI7DQo+PiAgIA0KPj4gKwkJaWYgKHJlY292ICYm
ICh4ZmVyID09IChzc2l6ZV90KSAtRUlPKSkgew0KPj4gKwkJCXByX3dhcm4oImRheF9yZWNvdmVy
eV93cml0ZSBmYWlsZWRcbiIpOw0KPj4gKwkJCXJldCA9IC1FSU87DQo+PiArCQkJYnJlYWs7DQo+
IA0KPiBBbmQgbm8sIHdlIGNhbid0IGp1c3QgdXNlIGFuIHVuc2lnbmVkIHZhcmlhYmxlIHRvIGNv
bW11bmljYXRlIGENCj4gbmVnYXRpdmUgZXJyb3IgY29kZS4NCg0KT2theSwgd2lsbCBoYXZlIGRh
eF9yZWNvdmVyeV93cml0ZSByZXR1cm4gMCBpbiBhbGwgZXJyb3IgY2FzZXMuDQoNCnRoYW5rcyEN
Ci1qYW5lDQoNCg==
