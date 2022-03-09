Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681994D34B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 17:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiCIQ0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 11:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238037AbiCIQVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:21:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373BF2B269
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 08:17:49 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229ESaTM021312;
        Wed, 9 Mar 2022 16:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tHXXGBwxe9nXKPZc3d1EOXM8h44iOWYBZl8Yon5sTOc=;
 b=tfSeec6ZW7sk9u6FbmtRXEV+oJ7NjCvtDkZZIgpBCg/Uti63mpAPtH+/2+V0wlILRq+c
 GSADNSmyXihhvir53dJFfHDeuq9NhvlmOMG1d/j3mBi/5Yx3LpQjcsrYrSM/zDucnMAs
 XT58o4zNIp95msFLNe/bleYCgx1n1JOdyRTIFJIT7El/yZQCK5ZX5Cow28CkP4s3urUX
 7U6w7b0S8S37WSx4H2n0oWCQgvj235eFRwz0uk7g6fMPMfJ8GM5xxweiXXHdeHNGhFyP
 fw0ZUNL7FNjZx+EZ3kjRA6MuTIP309S20Zx5c81M+LeIqRWbTALK9RGB7GNrI1yD20r0 0A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekyfsjqne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 16:17:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229GCO11192644;
        Wed, 9 Mar 2022 16:17:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3030.oracle.com with ESMTP id 3ekvyvy3x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 16:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAisLJIgKHFYc0JeKXGdM/iCLQsJwEwyzqt8EyiDykrqubCcHCawWAtwlsHmXO3T8vwrk8hEXnpbo0ZYhsJL8EdgQtI2By2Y++06x+HPGbYfdHpSmPbbLKpS7LDLie0jScpiOFFpq2KiCi3NC6q+ooOzTxrZEcw7ZonR8j0FIN72bo6XZ9uMW9SpqSPA7KTgontnYhMaTBwjAbgkLaW8URa3ExpmyfnXyfMuDejEvHwDq8fs+1/8cJBcIomOgUqJQ/eTsiB0D3b3IgKCQbMoaFgSdrJ9YRELcMZEb8crOJh4xfSfH5a9VAbCLCSdvMXG0Jecu2vD1pU/OzQb+UZMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHXXGBwxe9nXKPZc3d1EOXM8h44iOWYBZl8Yon5sTOc=;
 b=l2B+XyuhrdSR+Po6R1vT52TZ6SxwnRXNRUcBY0GRy1yLo3JRsOJotNGHhNRzxopVOTm9kb3SHs9UQtXtFDfWzs0xIqD3cF+jybhrWVSnUw/ShMkmIO95g3fcVegie83sI7dAyRhLQEzDbDK6mwxyEWjtZ3vcV+uirlmCHUOk0LgHWqDM0YXp1g9NGu+Dl16o+bKcYeAL9/hRhgP+FP4tjo+SjHZ3dhyZaeFidtvbNnsYLlYjCAmBicIqGrcBVZhLHbbeC3qEnOPFea4wMMFA+q74FcxLZ5Bv+ooDKB0r2wcBszgWFNyrmKsPb+c7zyqweOReVoA8e3ZAnoW+85AsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHXXGBwxe9nXKPZc3d1EOXM8h44iOWYBZl8Yon5sTOc=;
 b=Y4dBg1csmBVqzjxxbkAW2Bw+8IDwz177et9Ilc/fflKCxZnePusEk9Iwp8d6ElfcomvyHvEisTJqllLh7u1SWAFMYYu8GfpBe26fsTKNVdUqf1FaiaaJ7nddjZZODUR7yafu7nM+vyqLXkssx4xVUTOT+mbtpfeZYQ2SmtRFT98=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4934.namprd10.prod.outlook.com (2603:10b6:408:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 16:17:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 16:17:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steve French <smfrench@gmail.com>
CC:     David Howells <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
Thread-Topic: [LSF/MM/BPF TOPIC] Netfs support library
Thread-Index: AQHYFuZsVN49lu1TCki88X55Ds7H8ax99cIAgDHjLgCAB5umAA==
Date:   Wed, 9 Mar 2022 16:17:39 +0000
Message-ID: <C9AC7BE7-E72A-47FC-AF70-0134AE9AAE66@oracle.com>
References: <2571706.1643663173@warthog.procyon.org.uk>
 <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com>
 <CAH2r5muY-bh6H5SSmAF37TAHiZCSa8-UbMKk2=HQEmxyK1vdsQ@mail.gmail.com>
In-Reply-To: <CAH2r5muY-bh6H5SSmAF37TAHiZCSa8-UbMKk2=HQEmxyK1vdsQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27a65670-0c46-4e06-1bd0-08da01e854b9
x-ms-traffictypediagnostic: BN0PR10MB4934:EE_
x-microsoft-antispam-prvs: <BN0PR10MB49344693EC98137DDD9616F6930A9@BN0PR10MB4934.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yEKATblICnMNGcO7Zju8v14MQ9lOmkmKBiE+1t914zDNH3c1yZIWMp3b3Rk0KFxl7CUgQQD4CW7a7nTgh/29ZuTsoZhbH1SZwxrqOK6eDmbLfMAmKEuR3fIvoMQW9OyYtY4GFTSNi0IEFemlP9QwRmKuJQec5Go7vTMoeuIoGiVzs0NWnvRGtQR1XEGEzButZPr0zEWJ2uFhDw5LQYQ/D93hbd6GHpWiAj8h8Fzx9QosI9PurB5sedYLjl1DlEoYLbOucd/OJci+oPMXPSJyRV8Ty3pEeaB+rquO7Xf5Tx8VWa6NH3Kpmzxs9yB6oS7S9dBylBLGK/7U2Gi47jCcMKOUvnJi175ZKVBLK3toFy/mqXdVLp9JYybqTGFJf8/4ZtqkP9HPU57GHGhHTHI6uendqLTejzW75mTR49vNgdbLWkB/QwDuEg8+O9pHzYRA6zdtstE1/sic6rPnlatSFsSZPDl2QsrT7cAWJqTlOlBDWkaXp58Y2eC24H1uLmREbcY0lIrijPJFZ1dwEyFMMDaY3Y8ZkHxmlFZiCnGyB7swT74PDBoF/ir9EFNkCuYvqjdsaxNKkJJ7D/OmIU48BLl2SabUOJJTNXoMZV8fVmfsefb2RzSkF/0ofh8aizdbnUWHUeOxl1JnUXgyrXASx/AnOKqm49Hq9GkNQlRdB66/w0VU+V4GaVzjE9OqlF8I0paj+X2Kh3YIuhC2tchXewP+2VI0UpC8x+B+sgvS2+5kZ6sq91sv0SqFGSOaC+IM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(76116006)(4326008)(66556008)(508600001)(38070700005)(66476007)(66446008)(64756008)(8676002)(6486002)(122000001)(83380400001)(5660300002)(8936002)(6506007)(91956017)(36756003)(53546011)(71200400001)(26005)(86362001)(186003)(316002)(38100700002)(2906002)(6512007)(54906003)(2616005)(33656002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i9Gu+4aVdFOiLUGipnsl5p8rSuMNiWUMuKMK49uxC2KnIFIXM7BQfzzUkoe7?=
 =?us-ascii?Q?Y00JmtHGmRgQCbF1IBLpNH5VJKe/7kD4NFLDdE5Dfi+VkV672l7SZ292wxEe?=
 =?us-ascii?Q?YJRZMCh9XbWZr468K2LenPY452Wtturr/5IrsoduyCfIOINz83/2nK74SEzo?=
 =?us-ascii?Q?Zv4u2SlBOBGWpsH0EktxPym0JTyewaaBsBoe/aNsNMVgBVr+BB1+QXBI9WzI?=
 =?us-ascii?Q?Wypz85L2HppwdnoFu1Gz2MPLcA4NgPY+t21vcBWhSQIibU6w0cKUpQ3hUT2j?=
 =?us-ascii?Q?ys6f+Uu5cnvmlCHtUTrmbIyCPSGkdgsUYJXrh5FC1oByDCMejFKIVRGSBXvo?=
 =?us-ascii?Q?K3r/VrCBpR5qREM9NN/W9S57e4juy2K7ArdNfQSP0tPgHvE3D27ckM7SDkcz?=
 =?us-ascii?Q?HxMO6WhyaiKIPZ+E3KudvBXmgfuPw+6ycyCP67J4Ni47HTkg7H/K1fz/L2vq?=
 =?us-ascii?Q?lrpbDYxr5fPiXq1J0xEthG5AS9WgfPAupHmAnIs9DaVuzmF5LhmXi4zfAjvx?=
 =?us-ascii?Q?Z0AxG24cSaim+E7XCoDnNZky70qzCv7eMWHiVGtwR8Ug1ufMWRcSokROIjvh?=
 =?us-ascii?Q?/xzAFoL1sQ+a++HeP8nTDPFj7SiPJJVEirCvuoKdalyJb8KvBfN95Fpqd0s1?=
 =?us-ascii?Q?1rwE/Yy6nsRbe2I4zZ0QA3PSwYfbYOEmIXdlVslCApmhV41CmujqCO5Q/gKN?=
 =?us-ascii?Q?8JUutliWwfIkNtiqqTHOsypzIDmwLxpC1jWYXG3/sFJGI0F/gvVb0pqYs+AE?=
 =?us-ascii?Q?eDFDVlXkxbq1xMsjtyi+k802CvJ2jHwnTnN6ij88u5clDq5SBobrNKwdhO42?=
 =?us-ascii?Q?GhRzDBWQDbk7UviOuyxxGECSererRh0t2yoIw8HgasG5sp9lhaxRd1svEzFE?=
 =?us-ascii?Q?jugmXFLcLiJi9pzGcq5ysLH37lGX7udD6xMkqpHNAmasGMcGK835hS9nlRUt?=
 =?us-ascii?Q?zhH6UWTQ3wk3QAk7RhsYV+AFFTcjHRpxVhb9Hbken5EtoHBr06FpUV5D6DPz?=
 =?us-ascii?Q?ni8ewiqAMUdnEt1wicbykoMHBDzRV8qGTO44FqvMKk1s7eVA+T8JS9lLwGM7?=
 =?us-ascii?Q?Jp1rpsaF+XVzfzRX/EHm/Lgp4J+EpkupRD6HnR0qYapEfdBraimmNKWCeoDg?=
 =?us-ascii?Q?+0VKyeqXeLnLc8iBq4eUFfbaJnMs70tcWrDaI/FW83nXudUgxcInxR7hOhx4?=
 =?us-ascii?Q?a1aufNTfIgwk3UAl9cbsz53XXNsiFVt6w5x+hkWTVNzFhFJgwLL+UInrE9iP?=
 =?us-ascii?Q?8bb+t4nWWSA8DoNsbdoZpH/QcUNgoE1qBqDdSugPFnrBvI2rWKS+jqL6XaBe?=
 =?us-ascii?Q?NbU3cvAeFfu2YKcaMMbN8fzLbclCp331u77cdTOe0Bvql+V3bJ2ZlKIjiDIs?=
 =?us-ascii?Q?ysBUon3SPw5jVzvqIVmSntPsAjb67P5LnenAFKvUdV8wgj+KCQ+nFNdXOHHk?=
 =?us-ascii?Q?H/BmdqTpMCWuP8gn+/Swg1lW73dZK+2uVnI7TzPX1UhK45/h5bxLsXRRm7Az?=
 =?us-ascii?Q?BUBGYs92M9UKH1ZJqQbqv1WRR4p0xxY4LVFjdBEYaK+C22FyIEPefJN155a6?=
 =?us-ascii?Q?fdmh0mEN8avPUj14VvRcYyFefOZ3vBcdP05EOsLpqOeGurK5Jm6cQuWU133E?=
 =?us-ascii?Q?jf+f2H8PR+0Vg7DDVhQj1lw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FAE02C32F95984E8C6A780982FB4AE0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a65670-0c46-4e06-1bd0-08da01e854b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 16:17:39.1179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqFv0YMsaFReKz+Yn9mokD0IS4LLIGwSKMkGzqqodPGJei2wFE/nUxHaPvcGc7+YJQZEgtYjlOxUunV/x5fAAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4934
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203090091
X-Proofpoint-GUID: 14U1gU12Drm6BkuvS0LirfHald4ROtQM
X-Proofpoint-ORIG-GUID: 14U1gU12Drm6BkuvS0LirfHald4ROtQM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Mar 4, 2022, at 3:06 PM, Steve French <smfrench@gmail.com> wrote:
>=20
> On Tue, Feb 1, 2022 at 10:51 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>>=20
>>> On Jan 31, 2022, at 4:06 PM, David Howells <dhowells@redhat.com> wrote:
>>>=20
>>> I've been working on a library (in fs/netfs/) to provide network filesy=
stem
>>> support services, with help particularly from Jeff Layton.  The idea is=
 to
>>> move the common features of the VM interface, including request splitti=
ng,
>>> operation retrying, local caching, content encryption, bounce buffering=
 and
>>> compression into one place so that various filesystems can share it.
>>=20
>> IIUC this suite of functions is beneficial mainly to clients,
>> is that correct? I'd like to be clear about that, this is not
>> an objection to the topic.
>>=20
>> I'm interested in discussing how folios might work for the
>> NFS _server_, perhaps as a separate or adjunct conversation.
>=20
> That is an interesting point.   Would like to also discuss whether it
> could help ksmbd,

Agreed that ksmbd might also benefit.

Of primary interest is how read and write operations move
their payloads from the network transports directly to the
page cache. For the most efficient operation, the transport
layer would need to set up a receive buffer using page
cache pages instead of what is currently done: receive
buffers are constructed from anonymous pages and then these
pages replace the file's page cache pages.

RDMA transports make this straightforward, at least from
the transport layer's perspective.


> and would like to continue discussion of netfs improvements - especially =
am
> interested in how we can improve throttling when network (or server)
> is congested
> (or as network adapters are added/removed and additional bandwidth is
> available).

As I understand it, the protocols themselves have flow control
built in. At least SMB Direct and NFS/RDMA do, and NFSv4
sessions provides a similar mechanism for transports that don't
have a native flow control mechanism. I'm not sufficiently
familiar with SMB to know how flow control works there.

However, each of these mechanisms all have their own specific
rules. I'm not sure if there's much that can be extracted into
a common library, but can you be more specific about what is
needed?


--
Chuck Lever



