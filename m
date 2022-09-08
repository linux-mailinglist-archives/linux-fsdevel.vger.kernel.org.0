Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8505B2852
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 23:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIHVSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 17:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIHVSI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:18:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B1ED7423;
        Thu,  8 Sep 2022 14:18:07 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Kf1Xq002655;
        Thu, 8 Sep 2022 21:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=hnyeroypxtkoj9q390v+rBN0P3TUSNbmvZYQrjnVfwU=;
 b=rcMwljt7JYg2F8/mHspNuIQHkGUoxyyyyTPEYxWdZsnK5F8H0zyeiXRf+SIPv5uvYT41
 1m4NtkCKEo6v8F3JT9ibJs5SFwN8KyFU1/9TVgqCc4blBX8FAvb6qYLSAZH7vHNx/3QV
 W0HieEC3fl1tveP/cDFPUHO7CUoIckOYtBaRm2Oti3GgDR5LYcGREqN3VSF3171EN9/U
 WhCHNXeca9tmGZvjXtSt07/exTraOxZxUr8r8SE0r5tkziJY0ghcOiejkgNFeBFIBVAX
 rQ/CxNWy4abwG3eMrZ3aXR3dfagFcePsiUxHoZJgqkfrtsr4h/OOquFVbPkWNfWxkV7Q KA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtamyt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 21:18:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288I0Qim006899;
        Thu, 8 Sep 2022 21:18:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6pwqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 21:18:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAkgMP5vx3svzCayhzEfIgrLMh+NMOW3RgOLgw2/GhLkoyFCn8fGl7Fc2ZeAbZZ5Wj+YizCBds5n/VGvMgwrVyZCnt2gtSLphYg56Rzbq8INtVDQCa9hexk6OXrhvGVAstg5XM2ZaoqUE/qm/qgiOLQ678oEsTL3aEuEuwipIt5kV7RKuw8bXydgexP4ALBsntRgbb9JHrHGVyHjFdAvZq73WsimAq4nCacMHfLP6gNizxGfNCbiK9fgTyFjL8Cpj4KnYM7v9tCbN02ElwQGbh+Cvzdz6aJ1GT77wQ57q7xxDjgw/Y5H2OFhWnleCwrDPAKz35Uz9Ddca+l1A7e1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnyeroypxtkoj9q390v+rBN0P3TUSNbmvZYQrjnVfwU=;
 b=kWKj9yN11FU2z/lmWck12XBCfekqy1oiYH3zf4dOcKK3zkvyeMkin4rWNby1/0u96LnB5DkxORY42ni5rbuk0W3fuJIbQM6ISgrc+Pw9xq/KYFhDIBnkd9GLj1/AtOhrfAz+b/G9k7v5bFQFyoksIAkjgKX5HoFI9m6eb0cV+oOXFjvwisucbc0MBpoi8Xln7zbpbWtsA8tc9OkXQ0JyUnNktzekRlvQVGhjNXfXVDDzS3EjXncFb97fxtI3SkWXEHDDZ0meq80n7ZzVjCz00+cHQW6GfE0IBuT9R3NY03v01X1li8eX3wVnCeo5JE5+8nvS72+19pCT9xtvekCcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnyeroypxtkoj9q390v+rBN0P3TUSNbmvZYQrjnVfwU=;
 b=hdxBMukEPVx3SLOab5sChnrSrS444xjiMZmaE2m31p6RPoNSmnmcbyMDWJR6e3T63VEJsI4Oe4pxvHExId6YeY/oFf1lYaVhFzhzUY4kaGKuPS2F+4U9waStPcBl+mCHk++D+FmAkI0VQWH84XWEKOAdLvepDTJOtNSQKy86g8E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5162.namprd10.prod.outlook.com (2603:10b6:610:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 21:18:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 21:18:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     battery dude <jyf007@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: Does NFS support Linux Capabilities
Thread-Topic: Does NFS support Linux Capabilities
Thread-Index: AQHYw36p6D3ymO0jXE6pVWwFMO2Oyq3V+t+AgAAK5oCAAAQugA==
Date:   Thu, 8 Sep 2022 21:17:59 +0000
Message-ID: <9DD9783E-0360-4EC0-B14A-A50B5176859D@oracle.com>
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
 <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com>
 <2b75d8b1b259f5d8db19edba4b8bbd8111be54f4.camel@kernel.org>
In-Reply-To: <2b75d8b1b259f5d8db19edba4b8bbd8111be54f4.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5162:EE_
x-ms-office365-filtering-correlation-id: 3828e5ad-f6b7-42e4-a32c-08da91df9b8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zeNUk7/WfV+B9b1ds4I5mSlb75kbfjyFbUi6sU10pEuxZ2nwAKSDNuQfEyEswl6VgRPuKBqn3fhTUccgitaAxrIp5G6KRwXmuRjnPBiD3K3D18KdGzMhqAktNp4CQpLoToGkkB4S/HnQ38bVxiUuxxsg8wBBQq9OQjvwQKukArcq+fYHGerE4/PdbdjbPMUGpBrpAzZcl0yioGFxp0/rhDF7kVbQYzTYDpb7I2n68azs6tMRlioSeyQ7cDw7YRwEKQvVaJkjXOIGmy/YWWCbDzWF4n6Ws4ZgvAKjl17c6APk7eR8jd5ysqX/CaAuUtd92dPCoXtlSFDnD8eQKOD4tbKJ2YHG/Su5A3u2q3xxU5uW4kZ4lJf9xqjfQNiilYY/4l/srTCfYLnO0kXQ9NKtMj2coQ95eIl80Ya9nRUuYV00EHCdV7u7FY0KA5OIo9LU7FGDkaIbNOyoy5kC678m+p/TXFz4www3eOLsyN0BlkzaPR07WkpK3q4WMOQDWThKAmFdkE6fzTUv2jGFvi6N7yuhkvlvbKKzmUK4trSLAuQ4Jp3FCm9TjArU+WeNiQU5jkF3AQ5pCqSHvD4cOj64gE+FLrT1wtncNm18B+fAFcNUa52iAuCBlLi6nCrK7qlySzyqyfGFff/iMouxMRPHa63f/5zZqL3x9fhHoYJjVeE0yhDNrAEywIh5EZe1KxwwonKWQMv6I8c1n3cVRRfX/wdZesbCYkLjDkPt8Xyz3RfBonI/z4RX1exA+H8avUxF/apkfrdfcZmyED+0wSoaR85hJhNKR5MeaENDxQlMqgzstywQG0DRbVHnyRLdEdxu7y/V3ZRF4xX8sZRm29qafg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(366004)(39860400002)(346002)(316002)(54906003)(122000001)(38100700002)(66556008)(6916009)(71200400001)(6486002)(966005)(91956017)(36756003)(8676002)(76116006)(478600001)(66446008)(4326008)(66476007)(66946007)(64756008)(38070700005)(86362001)(2906002)(33656002)(5660300002)(53546011)(8936002)(66574015)(41300700001)(186003)(2616005)(26005)(6512007)(83380400001)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHVmNURoWHpxMmt0WWU0ZDlpYk5iWXdSUmxLSzZJR09yRDRSUHRzUm1URldm?=
 =?utf-8?B?UFZZMlVhZ0xmWTV5ZDlZNGN1cDF1akdGcXV2aDB4bmxjRUEzRjIyRHRKS1pq?=
 =?utf-8?B?NGdtcnNaN1BnTVpCdTcyOFpkbFA4MVB3MFN4eWpIVGcwVWVYYWxmZ2ZtbzY2?=
 =?utf-8?B?R3drb2NBdGJHUlNrZHN4R0d6UEk3bGU4bW9KcFdtUjV1QnZqMjg0VTQ1cDBn?=
 =?utf-8?B?bkZzL1NtRTRhdlZGQTF4YmIzN0RZeDdHamc3UXdXUEF4czlxTGhhVmFVZzBt?=
 =?utf-8?B?UjNPUlhocElCRER5bWlSRENydlR4U1FjUGxIUE8waUdqRnRUTU5IMXVKanlr?=
 =?utf-8?B?WURtNlZkZTdVUlJRM29IVlFVZEN5UmJRdmpCN3ZxL0FibmtQK0o2d05FL3hC?=
 =?utf-8?B?RkF0cWZocy9DelMzcTZqZjcxYnNJYWhnZGNrZTkyQm9jdGlQYmUwcDU1V2Rw?=
 =?utf-8?B?WjZtSXVFd1h2NGtmTmNJejk1NDJGcTVFNElLUkloaXFzcXREM0N3MmREc05h?=
 =?utf-8?B?YmlBa2pJTUJ3SDdLMytQcEtoaGpsdjFDV2JhZXJxeWpSRDBOMFBKYXI2aW5s?=
 =?utf-8?B?RjNMa2dTTFNXbzRlaFpKdUNQMlVWbCt1RjhHVDhrYVl5Q000V3dmWjdiQTlW?=
 =?utf-8?B?Skx4clF1KzVNeXpKcCsrQjhBcmZlUEpseUdpZnZWdDJ3bElPWDdFQnFYdEpI?=
 =?utf-8?B?bEJ0QmF0N0tZUDRVWm9kYjNJRFdmUGk3OGVvS2V6ZUI0MGVSa1lHZXEzVVE2?=
 =?utf-8?B?Q3BPYUdnN0tGTDF3NU5YWWtFSnlrSjA1SzU5c2Z6RVA1bnhXc1NNWXJkcWdj?=
 =?utf-8?B?RGdTZFRBcXE2S3lIUm0zb3dHTHhqUUVjK2U4NkJmZkNGZzhHWEVIN2p4ZGFa?=
 =?utf-8?B?WUpPMXJudm8zeTVvN09QeFFuMDRoMmNSTjFxUU96VGNIRDVOeHlQTVFkUWFy?=
 =?utf-8?B?QWREZnNVdW5RSGpGWWh3VnRLblJWWmNoc2MyY3lsWTJQUVhjRmUwYlYyNUY3?=
 =?utf-8?B?aGljbXNxKzNnSE40K3VhWENDTlU4bDVubUZqaUxFbjVXLzA4czhLQW5lRDdZ?=
 =?utf-8?B?U2JPRm1IdFMvQTd2cG5SUjJuVG1CMEpxcmIwQ3h0aFhhZThoWjYvRjZ0K0dv?=
 =?utf-8?B?MjM3UVd2NjBNejVZVTFmdnZJOU5LSERSOW1sQmwxTXJqTXdSUGxjQ0NDZGlq?=
 =?utf-8?B?MFM0Ujd6ZXgzZnh5ZnV3VTY1dHhkZ1pLWUpXaW1aUi8rWjRoV3Uway9LTlgz?=
 =?utf-8?B?Q05LRzhwN1RmMmlxckxoTENZZWdZNmhiTkJNM2pUS1Q2aHhmbCtCb2pVWjlG?=
 =?utf-8?B?NGREM2VWV2p0WnQvcHpyblJiKyt2c255TDc5TVFLdWdicVdpbTBoRmNxbXBJ?=
 =?utf-8?B?MU1KdHFFWmNjK3IweXNrNDlEaEtUUGlFMDB0d0t2MEs3VXkrblZIMDYwOGpx?=
 =?utf-8?B?Q0lid0JISGthWTNLcWtaODI1UFFpSk1Yb21kREZ0OUF5SHEvdndjYzMwZTlJ?=
 =?utf-8?B?blpHRFR6d1liZDlvT3BhZS9iVGJRTk9hTE9CdzF3WkVlMTl0NDhxRHpsM05Z?=
 =?utf-8?B?Ny9tS0w5NzBLMlR5ZUw0akYwOEE2bWtxbmlhMEw3WWlOS1hYdnRaYUQrS1NM?=
 =?utf-8?B?QjNVSFlqRm1Sa3FiM2NtcGZlditzUmIyZ2tNWFZvTFkrUnBXNHIvZ3FuZ21I?=
 =?utf-8?B?T1lDUVhERkEwbktTOEJ3RHFJbEVQajZwelVlTkdpZFRvUVZ5OU13MlBqcE5w?=
 =?utf-8?B?RjJmZWVxRStubEw4WmdwWmY1Znh5d3FoUU9Hdm91OWZuRW1XUWVkZFVFcUZB?=
 =?utf-8?B?c1F4eXg1eUhyLytkY3V3SkgvVWhIamNwZDBGVE40SnVTaGg2RFRXOVd6c292?=
 =?utf-8?B?clZpWk5rNUVLSUhqWDdsZzJkZFFDVXdsdlNzeWRCTjBQaW43ZzBiTGU1Rm1j?=
 =?utf-8?B?bUcvYkVlQ0FOaThZdVUzT2dwSERIZDlDVDBacSsxd1hXUUVteVE4UktreVo2?=
 =?utf-8?B?QkpFTkJCbjZFc3BITitmTitOTnpWOW5kS0dhbW9Sa0l3eis3aWFBWG40SmZB?=
 =?utf-8?B?blpEbXBHSXpqcGpGeUV5b3RJSUhkbU12OCt3WnZRU0tTUWkxMStXVUNhOTJN?=
 =?utf-8?B?OEhyWHNCQ0hpeWN5bUJ3c3RkVWUraXpoNCt4Wk9reVNlZGk0cnVsRmZxQ0d2?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19BAA77DAEA5A942B53CEAB78D57B726@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3828e5ad-f6b7-42e4-a32c-08da91df9b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 21:17:59.9494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0QVky6jRsWul0Q3PtYUai8FdELbD+ECeb8YO/e5HRaURUwRWvkYmgYIkY5awnYIQR+qVLmqLxC1McVbOdTM6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080076
X-Proofpoint-ORIG-GUID: CnAXrIP9JHHT6te5xhHEmBy_omp1u5ps
X-Proofpoint-GUID: CnAXrIP9JHHT6te5xhHEmBy_omp1u5ps
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gT24gU2VwIDgsIDIwMjIsIGF0IDU6MDMgUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDIyLTA5LTA4IGF0IDIwOjI0ICswMDAw
LCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+PiBbIFRoaXMgcXVlc3Rpb24gY29tZXMgdXAgb24g
b2NjYXNpb24sIHNvIEkndmUgYWRkZWQgYSBmZXcgaW50ZXJlc3RlZA0KPj4gIHBhcnRpZXMgdG8g
dGhlIENjOiBsaXN0IF0NCj4+IA0KPj4+IE9uIFNlcCA4LCAyMDIyLCBhdCA4OjI3IEFNLCBiYXR0
ZXJ5IGR1ZGUgPGp5ZjAwN0BnbWFpbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEFjY29yZGluZyB0
byBodHRwczovL2FjY2Vzcy5yZWRoYXQuY29tL3NvbHV0aW9ucy8yMTE3MzIxIHRoaXMgYXJ0aWNs
ZSwNCj4+PiBJIHdhbnQgdG8gYXNrLCBob3cgdG8gbWFrZSBORlMgc3VwcG9ydCB0aGUgcGVuZXRy
YXRpb24gb2YgTGludXgNCj4+PiBDYXBhYmlsaXRpZXMNCj4+IA0KPj4gVGhhdCBsaW5rIGlzIGFj
Y2Vzcy1saW1pdGVkLCBzbyBJIHdhcyBhYmxlIHRvIHZpZXcgb25seSB0aGUgdG9wDQo+PiBmZXcg
cGFyYWdyYXBocyBvZiBpdC4gTm90IHZlcnkgb3BlbiwgUmVkIEhhdC4NCj4+IA0KPj4gVEw7RFI6
IEkgbG9va2VkIGludG8gdGhpcyB3aGlsZSB0cnlpbmcgdG8gZmlndXJlIG91dCBob3cgdG8gZW5h
YmxlDQo+PiBJTUEgb24gTkZTIGZpbGVzLiBJdCdzIGRpZmZpY3VsdCBmb3IgbWFueSByZWFzb25z
Lg0KPj4gDQo+PiANCj4+IEEgZmV3IG9mIHRoZXNlIHJlYXNvbnMgaW5jbHVkZToNCj4+IA0KPj4g
VGhlIE5GUyBwcm90b2NvbCBpcyBhIHN0YW5kYXJkLCBhbmQgaXMgaW1wbGVtZW50ZWQgb24gYSB3
aWRlIHZhcmlldHkNCj4+IG9mIE9TIHBsYXRmb3Jtcy4gRWFjaCBPUyBpbXBsZW1lbnRzIGl0cyBv
d24gZmxhdm9yIG9mIGNhcGFiaWxpdGllcy4NCj4+IFRoZXJlJ3Mgbm8gd2F5IHRvIHRyYW5zbGF0
ZSBhbW9uZ3N0IHRoZSB2YXJpYXRpb25zIHRvIGVuc3VyZQ0KPj4gaW50ZXJvcGVyYXRpb24uIE9u
IExpbnV4LCBjYXBhYmlsaXRpZXMoNykgc2F5czoNCj4+IA0KPj4+IE5vIHN0YW5kYXJkcyBnb3Zl
cm4gY2FwYWJpbGl0aWVzLCBidXQgdGhlIExpbnV4IGNhcGFiaWxpdHkgaW1wbGVtZW50YXRpb24g
aXMgYmFzZWQgb24gdGhlIHdpdGhkcmF3biBQT1NJWC4xZSBkcmFmdCBzdGFuZGFyZDsgc2VlIOKf
qGh0dHBzOi8vYXJjaGl2ZS5vcmcvZGV0YWlscy9wb3NpeF8xMDAzLjFlLTk5MDMxMOKfqS4NCj4+
IA0KPj4gSSdtIG5vdCBzdXJlIGhvdyBjbG9zZWx5IG90aGVyIGltcGxlbWVudGF0aW9ucyBjb21l
IHRvIGltcGxlbWVudGluZw0KPj4gUE9TSVguMWUsIGJ1dCB0aGVyZSBhcmUgZW5vdWdoIGRpZmZl
cmVuY2VzIHRoYXQgaW50ZXJvcGVyYWJpbGl0eQ0KPj4gY291bGQgYmUgYSBuaWdodG1hcmUuIEFu
eXRoaW5nIExpbnV4IGhhcyBkb25lIGRpZmZlcmVudGx5IHRoYW4NCj4+IFBPU0lYLjFlIHdvdWxk
IGJlIGVuY3VtYmVyZWQgYnkgR1BMLCBtYWtpbmcgaXQgbmVhcmx5IGltcG9zc2libGUgdG8NCj4+
IHN0YW5kYXJkaXplIHRob3NlIGRpZmZlcmVuY2VzLiAoTGV0IGFsb25lIHRoZSBwb3NzaWJsZSBw
cm9ibGVtcw0KPj4gdHJ5aW5nIHRvIGNpdGUgYSB3aXRoZHJhd24gUE9TSVggc3RhbmRhcmQgaW4g
YW4gSW50ZXJuZXQgUkZDISkNCj4+IA0KPj4gVGhlIE5GU3Y0IFdHIGNvdWxkIGludmVudCBvdXIg
b3duIGNhcGFiaWxpdGllcyBzY2hlbWUsIGp1c3QgYXMgd2FzDQo+PiBkb25lIHdpdGggTkZTdjQg
QUNMcy4gSSdtIG5vdCBzdXJlIGV2ZXJ5b25lIHdvdWxkIGFncmVlIHRoYXQgZWZmb3J0DQo+PiB3
YXMgMTAwJSBzdWNjZXNzZnVsLg0KPj4gDQo+PiANCj4+IEN1cnJlbnRseSwgYW4gTkZTIHNlcnZl
ciBiYXNlcyBpdHMgYWNjZXNzIGNvbnRyb2wgY2hvaWNlcyBvbiB0aGUNCj4+IFJQQyB1c2VyIHRo
YXQgbWFrZXMgZWFjaCByZXF1ZXN0LiBXZSdkIGhhdmUgdG8gZmlndXJlIG91dCBhIHdheSB0bw0K
Pj4gZW5hYmxlIE5GUyBjbGllbnRzIGFuZCBzZXJ2ZXJzIHRvIGNvbW11bmljYXRlIG1vcmUgdGhh
biBqdXN0IHVzZXINCj4+IGlkZW50aXR5IHRvIGVuYWJsZSBhY2Nlc3MgY29udHJvbCB2aWEgY2Fw
YWJpbGl0aWVzLg0KPj4gDQo+PiBXaGVuIHNlbmRpbmcgYW4gTkZTIHJlcXVlc3QsIGEgY2xpZW50
IHdvdWxkIGhhdmUgdG8gcHJvdmlkZSBhIHNldA0KPj4gb2YgY2FwYWJpbGl0aWVzIHRvIHRoZSBz
ZXJ2ZXIgc28gdGhlIHNlcnZlciBjYW4gbWFrZSBhcHByb3ByaWF0ZQ0KPj4gYWNjZXNzIGNvbnRy
b2wgY2hvaWNlcyBmb3IgdGhhdCByZXF1ZXN0Lg0KPj4gDQo+PiBUaGUgc2VydmVyIHdvdWxkIGhh
dmUgdG8gcmVwb3J0IHRoZSB1cGRhdGVkIGNhcHNldCB3aGVuIGEgY2xpZW50DQo+PiBhY2Nlc3Nl
cyBhbmQgZXhlY3V0ZXMgYSBmaWxlIHdpdGggY2FwYWJpbGl0aWVzLCBhbmQgdGhlIHNlcnZlcg0K
Pj4gd291bGQgaGF2ZSB0byB0cnVzdCB0aGF0IGl0cyBjbGllbnRzIGFsbCByZXNwZWN0IHRob3Nl
IGNhcHNldHMNCj4+IGNvcnJlY3RseS4NCj4+IA0KPj4gDQo+PiBCZWNhdXNlIGNhcGFiaWxpdGll
cyBhcmUgc2VjdXJpdHktcmVsYXRlZCwgc2V0dGluZyBhbmQgcmV0cmlldmluZw0KPj4gY2FwYWJp
bGl0aWVzIHNob3VsZCBiZSBkb25lIG9ubHkgb3ZlciBuZXR3b3JrcyB0aGF0IGVuc3VyZQ0KPj4g
aW50ZWdyaXR5IG9mIGNvbW11bmljYXRpb24uIFNvLCBwcm90ZWN0aW9uIHZpYSBSUEMtd2l0aC1U
TFMgb3INCj4+IFJQQ1NFQyBHU1Mgd2l0aCBhbiBpbnRlZ3JpdHkgc2VydmljZSBvdWdodCB0byBi
ZSBhIHJlcXVpcmVtZW50DQo+PiBib3RoIGZvciBzZXR0aW5nIGFuZCB1cGRhdGluZyBjYXBhYmls
aXRpZXMgYW5kIGZvciB0cmFuc21pdHRpbmcNCj4+IGFueSBwcm90ZWN0ZWQgZmlsZSBjb250ZW50
LiBXZSBoYXZlIGltcGxlbWVudGF0aW9ucywgYnV0IHRoZXJlDQo+PiBpcyBhbHdheXMgYW4gb3B0
aW9uIG9mIG5vdCBkZXBsb3lpbmcgdGhpcyBraW5kIG9mIHByb3RlY3Rpb24NCj4+IHdoZW4gTkZT
IGlzIGFjdHVhbGx5IGluIHVzZSwgbWFraW5nIGNhcGFiaWxpdGllcyBqdXN0IGEgYml0IG9mDQo+
PiBzZWN1cml0eSB0aGVhdGVyIGluIHRob3NlIGNhc2VzLg0KPj4gDQo+PiANCj4+IEdpdmVuIHRo
ZXNlIGVub3Jtb3VzIGNoYWxsZW5nZXMsIHdobyB3b3VsZCBiZSB3aWxsaW5nIHRvIHBheSBmb3IN
Cj4+IHN0YW5kYXJkaXphdGlvbiBhbmQgaW1wbGVtZW50YXRpb24/IEknbSBub3Qgc2F5aW5nIGl0
IGNhbid0IG9yDQo+PiBzaG91bGRuJ3QgYmUgZG9uZSwganVzdCB0aGF0IGl0IHdvdWxkIGJlIGEg
bWlnaHR5IGhlYXZ5IGxpZnQuDQo+PiBCdXQgbWF5YmUgb3RoZXIgZm9sa3Mgb24gdGhlIENjOiBs
aXN0IGhhdmUgaWRlYXMgdGhhdCBjb3VsZA0KPj4gbWFrZSB0aGlzIGVhc2llciB0aGFuIEkgYmVs
aWV2ZSBpdCB0byBiZS4NCj4+IA0KPj4gDQo+IA0KPiBJJ20gbm90IGRpc3B1dGluZyBhbnl0aGlu
ZyB5b3Ugd3JvdGUgYWJvdmUsIGFuZCBJIGNsZWFybHkgaGF2ZW4ndA0KPiB0aG91Z2h0IHRocm91
Z2ggdGhlIHNlY3VyaXR5IGltcGxpY2F0aW9ucywgYnV0IEkgd29uZGVyIGlmIHdlIGNvdWxkDQo+
IHBpZ2d5YmFjayB0aGlzIGluZm8gb250byBzZWN1cml0eSBsYWJlbCBzdXBwb3J0IHNvbWVob3c/
IFRoYXQgYWxyZWFkeQ0KPiByZXF1aXJlcyBhIChzZW1pLW9wYXF1ZSkgcGVyLWlub2RlIGF0dHJp
YnV0ZSwgd2hpY2ggaXMgbW9zdGx5IHdoYXQncw0KPiByZXF1aXJlZCBmb3IgZmlsZSBjYXBhYmls
aXRpZXMuDQoNClRoYXQgd2FzIHRoZSBzdGFydGluZyBpZGVhIGZvciBhY2Nlc3NpbmcgSU1BIG1l
dGFkYXRhIG9uIE5GUyB1bnRpbA0Kd2UgZGlzY292ZXJlZCB0aGF0IE5GU3Y0IHNlY3VyaXR5IGxh
YmVscyBhcmUgaW50ZW5kZWQgdG8gZW5hYmxlIG9ubHkNCmEgc2luZ2xlIGxhYmVsIHBlciBmaWxl
LiBDYXBhYmlsaXRpZXMgYXJlIG9mdGVuIHByZXNlbnQgd2l0aCBTRUxpbnV4DQpsYWJlbHMuDQoN
Ckl0IHdvdWxkIHdvcmsgZm9yIGEgcHJvb2Ygb2YgY29uY2VwdCwgdGhvdWdoLg0KDQoNCi0tDQpD
aHVjayBMZXZlcg0KDQoNCg0K
