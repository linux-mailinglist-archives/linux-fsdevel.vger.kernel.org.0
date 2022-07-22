Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A8857E36D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 17:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiGVPJw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 11:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiGVPJu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:09:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F29F88127;
        Fri, 22 Jul 2022 08:09:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MEip5q013939;
        Fri, 22 Jul 2022 15:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2MrxQMIAjhm7Ikn3PgyxhaJzLxunZXSzqkUyu4ZTqWw=;
 b=gzm8DslSvRlBe5UuRU5NQbwxh/PLiEHa9NtuUfcTo0b9JlKEMFwoLYhDLgthkGtKhko7
 mj4vC+INnCYrg1XINxxj6POsLmP6wfjuVD0DZe08Lqq1qeQNE36s8AGF6mv506RYmcmq
 qRYDBdtXA/YzJQX7X1GMoDiyUTIx/cJy0/OGoDpLy9I8fg6DajLEXkW7gWO9pOFqi67J
 0jL4MtMZopvsaRI6wnN+hBaMMgxDIYn9+AOI2bzA4aatEowZMQDWE2NzSbhk1tJqT4iR
 /bJ5nWVaanOoHQm8w4rZzYcfHMQU7UnaeVeGGUmjtaBUyuWJg/x3GQTdnaIuz7/hwpiW vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtqsvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 15:09:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26MDwADF016474;
        Fri, 22 Jul 2022 15:09:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1eqv72p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 15:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZJRCqSwu7JktYv9AGPtr78UCyIjD7wPF7wHgVtxpURGtEU3SGikO+ytazg6vsQtL6VPbLbmk5IWj/2+PhLg0PcQLT2LUe+BdEFHX20+MI3oCJV77xOcL6S0e0eNFVRT148atYVrUmHB4lIyQgTalIxpyB0sW7CRqFP1pFXJW3CnE1x2F/nx3xztT9kJKdKslbwCc3ePjCHNIWXzLBa7tINKsu+93mqKgiFwZw+vWEaGqli4jXlCPjIraxxl559Byy5yGt/4f4vBiorYoRSKLqY8KEAGRnwxX0SOryIg8kk3YWNuMNW0bDtROdh7WriJygJy8l57qdrGPyRJ93UOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MrxQMIAjhm7Ikn3PgyxhaJzLxunZXSzqkUyu4ZTqWw=;
 b=UDTDvNenQnCvLjIgi993s7M2MsWHRbYPs4mXfqxEEDrKrMGRhM1/D+LmOpIrumCd8aSkEVfoCmHDPeRW1g3XbSYAjpnzYQRNq7J4jibamdkipD6/iynNhzGWbORKtdCXvNweZpJBCIepXYuUh2wgZc2YFNr7846/dgtqStR+XUYWa8ywuyPL95u+gDWLxjuxT6N8yeEIJ4sM2jO/jfM84hw586NIuL14JTKHwWE8o3XUUvGuuQWN/tbZ2q8xA5WOJHRkAx9KJ9MfAX8Zfr/SEJNv01Sth+GVLpk9mXNXdg0RYwc6SVxUoaPARYOdAr7qpcu42BTuNByzlx3btgbxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MrxQMIAjhm7Ikn3PgyxhaJzLxunZXSzqkUyu4ZTqWw=;
 b=sKy2wzE+WpWBbNuVIBIQpfeHTI+7zEYlM8vYIdrWQHnpbtZX1HPM9nuZyNsTx/Zy9A+48tGg/ZSPmlXaG9a4wZekeLZqyHvx0EZAKXdUOBV3ch3SAH+UdnCDQQpwE0pXjY3U2QoiWYosU/69DpCTKtfmmfl2H1D/HOwnw8wYMyM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN6PR10MB2813.namprd10.prod.outlook.com (2603:10b6:805:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 22 Jul
 2022 15:09:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%8]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 15:09:35 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dave Chinner <david@fromorbit.com>,
        Anna Schumaker <anna@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Topic: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Thread-Index: AQHYmHrzYsqP79DW8UWdtY79IK5gxq1/y34AgAOLZACAAtl+AIAAIOUAgAAtKQCAABONAIAAHJ4AgALo+gCAAPGRAA==
Date:   Fri, 22 Jul 2022 15:09:35 +0000
Message-ID: <C581A93D-6797-4044-8719-1F797BA17761@oracle.com>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <20220719224434.GL3600936@dread.disaster.area>
 <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
 <20220720023610.GN3600936@dread.disaster.area>
 <CD3CE5B3-1FB7-473A-8D45-EDF3704F10D7@oracle.com>
 <20220722004458.GS3600936@dread.disaster.area>
In-Reply-To: <20220722004458.GS3600936@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58cac4e6-8f05-4650-44d1-08da6bf43067
x-ms-traffictypediagnostic: SN6PR10MB2813:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3csEfPGJquBrIRtv5mC1URr2qGuyf6UJub1l4rqA5Q/yFpRtrBx73h39ZUwdcWLTeaL6iDDZGffIOV1ZNx15OKM8JtRT7PnOCUzxSBcSkytqeVQ1hZhASZ3I0Z+F7wb7fUFvEbZTHgQLTD9xQ7HRzS4RqlcGsDO5WrKUdWudmba8umYelMblyCqMqa0YM979g30ROzzRYoydRPVdgxLfQhs28BMmfOIRj8xMHvBVIRSRkBTsLd4BRW7U6C/e/8aPkPyKSGNmvry3hABliPW4Aa3S3k13BVlAnHI4K2WpEQOG1Hc6MnZ7ZEc/juiXkzvSoSD4ggd8uHUPX1Bh+TQsW5zm73GsHBZu9LszxwZwD5cGD7tdNGF+sc194Yp8oqyN64V5CwoqMiDvEb5MyoMSA82vWzgO8G/HQXjlwx/19CSyf4EVkIQ7/VK0OMO6SzSJ0igeb+1oT7m1WRU/q7Cs9SSF7PY8LcbZvJ74MoGroOQZvNp0OdpEWuq3YmSMeObizFRAFSIdkA7XlmfnZXB3jqNvKu1EeM/XNlf4A7f/WfEMwFi5m0ykpzop4Kwsan+ED3vKbceW8AAyhlruKuqlaQR2Fs4UG0BXw+oWx5XRxK9VqL9rRWaccVog0EU9/OM7QYgBAcaxzE/lZTSQ6VZgzrmcWOwZXnlNMxaq3uTJV+oMndlozMsevwwe//nrV9WT3qkEH4RNNWFH8cB+X1xhFknU6nepKZUkpxZmd9yU3RgDqD+LuO78yKHjqboEHTyliF0aNqv3ze1HEBku1RxXuvBaD4MHBAhXcgqgVthkeZWsIiCx/jnCFYFrBSRWARWKtihjmKxBxr+dZLSSAwBwVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(39860400002)(396003)(366004)(86362001)(33656002)(122000001)(38070700005)(38100700002)(478600001)(6486002)(8936002)(30864003)(5660300002)(316002)(76116006)(66946007)(71200400001)(66556008)(66476007)(91956017)(110136005)(54906003)(83380400001)(6512007)(8676002)(186003)(53546011)(6506007)(2616005)(4326008)(26005)(2906002)(41300700001)(36756003)(64756008)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7cgapPqZ9mnDezuhHbQGJCofwA+Dmqb2Kfg5MEBu3eUGZuEkQKburayaowEa?=
 =?us-ascii?Q?qxtSA9jmZFZd7mpuWIHESq5EOIcbMSgtZwPm2vrz3fWSbI043UNBpDHDentV?=
 =?us-ascii?Q?jfdIx2novup10ZApep+62RubWui+XiglYW3Z9h/JVjt+Qxi0Gqz9VPifoNtU?=
 =?us-ascii?Q?stRUSLg+k/vza/mU1tja2qXdMe6RA71r2qqnmjWMdOR/TtcHJRuJN/mfVBtl?=
 =?us-ascii?Q?Fu2a3LcT/vcHHecd97s+JStCNbsQljwh7eVQu6dzfPVTY9hxjuNtEY4qk4ev?=
 =?us-ascii?Q?oH20JHzW1uQmrjLHkzZfBr/Wv1iegclySTvju/6TIf7x5PzYKUYOeAOeREfr?=
 =?us-ascii?Q?K9/H6lZ4haJ3bNW7KDCZtzbIXv90NeHlvUuJPSP7TjH2FONPdaMCkyqIiz8k?=
 =?us-ascii?Q?dGDlwchz4b/n9Yz/jZQY43FGK6dzb4nn8xVBDQpzNq4lZsNzrunqojGuXhDH?=
 =?us-ascii?Q?IsHuhlet9EFghVu3ovZxeATwBw7acthjvr2KpSQBIxiAe9xkOoKv0NSH8c64?=
 =?us-ascii?Q?AcOVsE0nAcfgTqNq3r2oDsF1R8MLjLVnFUqaomGsWB8qODuAg9Nw/BwMah3X?=
 =?us-ascii?Q?PylxSoa61ulIjOePFE7rAEOD7rKviCsqRk8xHfNDMmlV+RlDQVKwPPdBz7sK?=
 =?us-ascii?Q?4l5x6AVTpwYyenHF3pq6WTL16RDGdk9goaUWMeYSSVDRzv+l2S1/RGGo1Rcc?=
 =?us-ascii?Q?oH6q4N8Eern3EO6DKWPA4bBTDY5r7JLufV82LVXrel/v+dj8LheRk+vg1zIr?=
 =?us-ascii?Q?SRdL5rwjJW7tvX7Y9wZDwvvqXSTqE63PbG1OeLdz0xjU9Nk+BE8lvJF/puwJ?=
 =?us-ascii?Q?L/q/C8XZGTRqKKzo8+VS9sK79U6K8X7z+LKERkepbnRO4V7gxfvDYlkGJZWu?=
 =?us-ascii?Q?7NLHLSTAXTtuFM3YEYAYKxGOf5Kp7otXHEwNnp8w12azVdbN81Y1pB30xx4d?=
 =?us-ascii?Q?YlqyXf7lK4u0LR2PXBVMyVBUTM5F/RDbc542UkYER+O+p7OIt73Od9eyCDiu?=
 =?us-ascii?Q?/0u9k/ypAFtbt5eFo+iKuyzmokWdXYicFuK1ycThmBucLuJvSUwQhyBQjeZx?=
 =?us-ascii?Q?kiI+V4am1aBjU0oe/drhgD+N7TZrXG03mYNu2y7Br0meNGLph0fiKKiIKVoq?=
 =?us-ascii?Q?2G0/qTzqie6JLmIg9vE8ZaQ1Y5KEvyqg7JAFJej2p4Q2xWj8ucHHrbz87wan?=
 =?us-ascii?Q?fTehdu93ftBCUuEZXq7yCw0NjiNgnUDgovq6/az4lwGvlRcNJzQu87QebrIc?=
 =?us-ascii?Q?+lsu6S2knih0O8kE0al13TAtS4kpyv/Uah5/4HZdrjm7KTgGSCvULDI5Dt5l?=
 =?us-ascii?Q?JZIJkfo+d+sgfi/w/Owkf3JbSZ5S36pTMaXw4DwGCalOABqL2KWcWcrBRGt8?=
 =?us-ascii?Q?lDCXEo0mp0JjoNAGU2K8Z7ZS1lxU+58IUWY72xBlIdR3QtHwl245Wai1bFJl?=
 =?us-ascii?Q?sBUpYDBN6LsklxgFGEooawXRwxn6Z33NjPnwJ3nsSzRWaxB1y/v6BDid7DkC?=
 =?us-ascii?Q?KW9JPQCbqXntdhgjOcn/UQelzKYs9j93D43J0Yw9EqBTwhrFOLxajJq471s4?=
 =?us-ascii?Q?XznJzRavw2X2d20peIWMFA8nWXGvlQyEpj/vgTP+KlRd3MxxuBQbRKHvYUz3?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7EDC52360172E0429C6C4A1BE3F50BF3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cac4e6-8f05-4650-44d1-08da6bf43067
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 15:09:35.4144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUGTN8BKeCC0ePAaOBG/G+mEoLAC8JFpuf7uovkcgpHKaorixPrmc4FP1JSJUmgHA8M3Ox0tbIpt3oJhprckpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220064
X-Proofpoint-GUID: czq7aUjmxr_BD05eedQGjMDK851vu0hb
X-Proofpoint-ORIG-GUID: czq7aUjmxr_BD05eedQGjMDK851vu0hb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 21, 2022, at 8:44 PM, Dave Chinner <david@fromorbit.com> wrote:
>=20
> On Wed, Jul 20, 2022 at 04:18:36AM +0000, Chuck Lever III wrote:
>>> On Jul 19, 2022, at 10:36 PM, Dave Chinner <david@fromorbit.com> wrote:
>>> On Wed, Jul 20, 2022 at 01:26:13AM +0000, Chuck Lever III wrote:
>>>>> On Jul 19, 2022, at 6:44 PM, Dave Chinner <david@fromorbit.com> wrote=
:
>>>>> IOWs, it seems to me that what READ_PLUS really wants is a "sparse
>>>>> read operation" from the filesystem rather than the current "read
>>>>> that fills holes with zeroes". i.e. a read operation that sets an
>>>>> iocb flag like RWF_SPARSE_READ to tell the filesystem to trim the
>>>>> read to just the ranges that contain data.
> .....
>>>> Now how does the server make that choice? Is there an attribute
>>>> bit that indicates when a file should be treated as sparse? Can
>>>> we assume that immutable files (or compressed files) should
>>>> always be treated as sparse? Alternately, the server might use
>>>> the file's data : hole ratio.
>>>=20
>>> None of the above. The NFS server has no business knowing intimate
>>> details about how the filesystem has laid out the file. All it cares
>>> about ranges containing data and ranges that have no data (holes).
>>=20
>> That would be the case if we want nothing more than impermeable
>> software layering. That's nice for software developers, but
>> maybe not of much benefit to average users.
>>=20
>> I see no efficiency benefit, for example, if a 10MB object file
>> has 512 bytes of zeroes at a convenient offset and the server
>> returns that as DATA/HOLE/DATA. The amount of extra work it has
>> to do to make that happen results in the same latencies as
>> transmitting 512 extra bytes on GbE. It might be even worse on
>> faster network fabrics.
>=20
> Welcome to the world of sparse file IO optimisation - NFS may be new
> to this, but local filesystems have been optimising this sort of
> thing for decades. Don't think we don't know about it - seek time
> between 2 discontiguous extents is *much worse* than the few extra
> microseconds that DMAing a few extra sectors worth of data in a
> single IO. Even on SSDs, there's a noticable latency difference
> between a single 16KB IO and two separate 4kB IOs to get the same
> data.
>=20
> As it is, we worry about filesystem block granularity, not sectors.
> A filesystem would only report a 512 byte range as a hole if it had
> a 512 byte block size. Almost no-one uses such small block sizes -
> 4kB is the default for ext4 and XFS - so the minimum hole size is
> generally 4KB.
>=20
> Indeed, in this case XFS will not actually have a hole in the file
> layout - the underlying extent would have been allocated as a single
> contiguous unwritten extent, then when the data gets written it will
> convert the two ranges to written, resulting in a physically
> contiguous "data-unwritten-data" set of extents. However,
> SEEK_HOLE/DATA will see that unwritten extent as a hole, so you'll
> get that reported via seek hole/data or sparse reads regardless of
> whether it is optimal for READ_PLUS encoding.
>=20
> However, the physical layout is optimal for XFS - if the hole gets
> filled by a future write, it ends up converting the file layout to a
> single contiguous data extent that can be read with a single IO
> rather than three physically discontigous data extents that require
> 3 physical IOs to read.
>=20
> ext4 optimises this in a different way - it will allocate small
> holes similar to the way XFS does, but it will also fill the with
> real zeros rather than leaving them unwritten. As a result, ext4
> will have a single physically contiguous extent on disk too, but it
> will -always- report as data even though the data written by the
> application is sparse and contains a run of zeroes in it.
>=20
> IOWs, ext4 and XFS will behave differently for the simple case you
> gave because they've optimised small holes in sparse file data
> differently. Both have their pros and cons, but it also means that
> the READ_PLUS response for the same file data written the same way
> can be different because the underlying filesystem on the server is
> different.
>=20
> IOWs, the NFS server cannot rely on a specific behaviour w.r.t.
> holes and data from the underlying filesystem. Sparseness of a file
> is determined by how the underlying filesystem wants to optimise the
> physical layout or the data and IO patterns that data access results
> in. The NFS server really cannot influence that, or change the
> "sparseness" it reports to the client except by examining the
> data it reads from the filesystem....

What I'm proposing is that the NFS server needs to pick and
choose whether to internally use sparse reads or classic
reads of the underlying file when satisfying a READ_PLUS
request.

I am not proposing that the server should try to change the
extent layout used by the filesystem.


>> On fast networks, the less the server's host CPU has to be
>> involved in doing the READ, the better it scales. It's
>> better to set up the I/O and step out of the way; use zero
>> touch as much as possible.
>=20
> However, as you demonstrate for the NFS client below, something has
> to fill the holes. i.e. if we aren't doing sparse reads on the NFS
> server, then the filesystem underneath the NFS server has to spend
> the CPU to instantiate pages over the hole in the file in the page
> cache, then zero them before it can pass them to the "zero touch"
> NFS send path to be encoded into the READ reponse.
>=20
> IOWs, sending holes as zeroed data from the server is most
> definitely not zero touch even if NFS doesn't touch the data.
>=20
> Hence the "sparse read" from the underlying filesystem, which avoids
> the need to populate and zero pages in the server page cache
> altogether, as well as enabling NFS to use it's zero-touch
> encode/send path for the data that is returned. And with a sparse
> read operation, the encoding of hole ranges in READ_PLUS has almost
> zero CPU overhead because the calculation is dead simple (i.e. hole
> start =3D end of last data, hole len =3D start of next data - end of
> last data).
>=20
> IOWs, the lowest server CPU and memory READ processing overhead
> comes from using READ_PLUS with sparse reads from the filesystem and
> zero-touch READ_PLUS data range encoding.

Agree on zero-touch: I would like to enable the use of
splice read for CONTENT_DATA wherever it can be supported.

Sparse reads for large sparse files will avoid hole
instantiation, and that's a good thing as well.

For small to average size files, I'm not as clear. If the
server does not instantiate a hole, then the clients end
up filling that hole themselves whenever re-reading the
file. That seems like an unreasonable expense for them.

The cost of hole instantiation is low and amortized over
the life of the file, and after instantiated, zero touch
can be used to satisfy subsequent READ_PLUS requests. On
balance that seems like a better approach.


>> Likewise on the client: it might receive a CONTENT_HOLE, but
>> then its CPU has to zero out that range, with all the memory
>> and cache activity that entails. For small holes, that's going
>> to be a lot of memset(0). If the server returns holes only
>> when they are large, then the client can use more efficient
>> techniques (like marking page cache pages or using ZERO_PAGE).
>=20
> Yes, if we have sparse files we have to take that page cache
> instantiation penalty *somewhere* in the IO stack between the client
> and the server.
>=20
> Indeed, we actually want this overhead in the NFS client, because we
> have many more NFS clients than we do NFS servers and hence on
> aggregate there is way more CPU and memory to dedicate to
> instantiating zeroed data on the client side than on the server
> side.
>=20
> IOWs, if we ship zeroes via RDMA to the NFS client so the NFS client
> doesn't need to instantiate holes in the page cache, then we're
> actually forcing the server to perform hole instantiation. Forcing
> the server to instantiate all the holes for all the files that all
> the clients it is serving is prohibitive from a server CPU and
> memory POV,

I would hope not. Server-side hole instantiation is what we
already have today with classic NFS READ, right?

Anyway, the value proposition of RDMA storage protocols is
that the network fabric handles data transfer on behalf of
both the client and server host CPU -- that way, more CPU
capacity is available on the client for applications running
there.

NFS servers are typically overprovisioned with CPU because
serving files is not CPU intensive work. If anything, I would
be concerned that hole instantiation would increase the amount
of I/O (as a form of write amplification). But again, NFS
server hardware is usually designed for I/O capacity, and
IIUC the server already does hole instantiation now.

But, it's academic. READ_PLUS is not efficient on NFS/RDMA
as READ because with NFS/RDMA the client has to register
memory for the server to write the payload in. However, the
client cannot know in advance what the payload looks like
in terms of DATA and HOLEs. So it's only choice is to set up
a large buffer and parse through it when it gets the reply.
That buffer can be filled via an RDMA Write, of course, but
the new expense for the client is parsing the returned
segment list. Even if it's just one segment, the client will
have to copy the payload into place.

For a classic READ over NFS/RDMA, that buffer is carved out
of the local page cache and the server can place the payload
directly into that cache. The client NFS protocol stack never
touches it. This enables 2-3x higher throughput for READs. We
see a benefit even with software-implemented RDMA (siw).

So we would need to come up with some way of helping each
NFS/RDMA client to set up receive buffers that will be able
to get filled via direct data placement no matter how the
server wants to return the payload. Perhaps some new protocol
would be needed. Not impossible, but I don't think NFSv4.2
READ_PLUS can do this.


> even if you have the both the server network bandwidth
> and the cross-sectional network bandwidth available to ship all
> those zeros to all the clients.
>=20
>> On networks with large bandwidth-latency products, however,
>> it makes sense to trade as much server and client CPU and
>> memory for transferred bytes as you can.
>=20
> Server, yes, client not so much. If you focus purely on single
> client<->server throughput, the server is not going to scale when
> hundreds or thousands of clients all demand data at the same time.
>=20
> But, regardless of this, the fact is that the NFS server is a
> consumer of the sparseness data stored in the underlying filesystem.
> Unless it wants to touch every byte that is read, it can only export
> the HOLE/DATA information that the filesystem can provide it with.
>=20
> What we want is a method that allows the filesystem to provide that
> information to the NFS server READ_PLUS operation as efficiently as
> possible. AFAICT, that's a sparse read operation....

I'm already sold on that. I don't want NFSD touching every
byte in every READ payload, even on TCP networks. And
definitely, for reads of large sparse files, the proposed
internal sparse read operation sounds great.


>> The mechanism that handles sparse files needs to be distinct
>> from the policy of when to return more than a single
>> CONTENT_DATA segment, since one of our goals is to ensure
>> that READ_PLUS performs and scales as well as READ on common
>> workloads (ie, not HPC / large sparse file workloads).
>=20
> Yes, so make the server operation as efficient as possible whilst
> still being correct (i.e. sparse reads), and push the the CPU and
> memory requirements for instantiating and storing zeroes out
> to the NFS client.

Again, I believe that's a policy choice. It really depends on
the CPU available on both ends and the throughput capacity
of the network fabric (which always depends on instantaneous
traffic levels).


> If the NFS client page cache instantiation can't
> keep up with the server sending it encoded ranges of zeros, then
> this isn't a server side issue; the client side sparse file support
> needs fixing/optimising.

Once optimized, I don't think it will be a "can't keep up"
issue but rather a "how much CPU and memory bandwidth is being
stolen from applications" issue.


>>> If the filesystem can support a sparse read, it returns sparse
>>> ranges containing data to the NFS server. If the filesystem can't
>>> support it, or it's internal file layout doesn't allow for efficient
>>> hole/data discrimination, then it can just return the entire read
>>> range.
>>>=20
>>> Alternatively, in this latter case, the filesystem could call a
>>> generic "sparse read" implementation that runs memchr_inv() to find
>>> the first data range to return. Then the NFS server doesn't have to
>>> code things differently, filesystems don't need to advertise
>>> support for sparse reads, etc because every filesystem could
>>> support sparse reads.
>>>=20
>>> The only difference is that some filesystems will be much more
>>> efficient and faster at it than others. We already see that sort
>>> of thing with btrfs and seek hole/data on large cached files so I
>>> don't see "filesystems perform differently" as a problem here...
>>=20
>> The problem with that approach is that will result in
>> performance regressions on NFSv4.2 with exports that reside
>> on underperforming filesystem types. We need READ_PLUS to
>> perform as well as READ so there is no regression between
>> NFSv4.2 without and with READ_PLUS, and no regression when
>> migrating from NFSv4.1 to NFSv4.2 with READ_PLUS enabled.
>=20
> Sure, but fear of regressions is not a valid reason for preventing
> change from being made.

I don't believe I'm stating a fear, but rather I'm stating
a hard requirement for our final READ_PLUS implementation.

In any event, a good way to deal with fear of any kind is
to do some reality testing. I think we have enough consensus
to build a prototype, if Anna is willing, and then assess
its performance.

There are two mechanisms:

1 The sparse internal read mechanism you proposed

2 The classic splice/readv mechanism that READ uses


There are three usage scenarios:

A Large sparse files that reside on a filesystem that supports
  storing sparse file

B Small to average size files that may or may not be sparse,
  residing on a filesystem that supports storing sparse files

C Files that reside on a filesystem that does not support
  storing files sparsely (or, IIUC, does not support iomap)


I think we agree that scenario A should use mechanism 1 and
scenario C should use mechanism 2. The question is whether
mechanism 1 will perform as well as 2 for scenario B. If
yes, then READ_PLUS can use mechanism 1 to handle scenarios
A and B, and 2 to handle C. If no, then READ_PLUS can use
mechanism 1 to handle scenario A and 2 to handle scenarios
B and C.

Both mechanisms need to be implemented no matter what, so it
looks to me like very little of the prototype code would be
wasted if such a change in direction becomes necessary once
performance evaluation is complete.


--
Chuck Lever



