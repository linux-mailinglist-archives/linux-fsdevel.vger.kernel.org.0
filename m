Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE34F0452
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357114AbiDBPMN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 11:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357109AbiDBPML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 11:12:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386535F8FD;
        Sat,  2 Apr 2022 08:10:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2323wbgG023318;
        Sat, 2 Apr 2022 15:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HFurWTGhvdywxF1lx3ry4Yj5SmLgYTez1w3jG2Ufw5Q=;
 b=FxOqFCOi1seQZ68YyyQXHDUowh8mZg8RVHGa+GKYxIwxWBBKKpTnby6t05Yv+ehU0U2n
 LJfHX2jn3Qyz31pflt5diRqjZHBLeJpIiB0RRQO70Oxvv2/0jYC8ai0xdv1APoyKpT66
 DF+2LZORuluPD2o4YO2IaeyNXfxrnoJZ/MmEOxlRXD1QHvBFLDd6oN0ZpORPqRenvL5m
 UssgxIbqczbny4AG4GyI1ZeD7ig+jcOwzw3a/E9JDrSI+5QF3m+uQN3T1PbSiVelL/7Z
 OWY9lS8avKz7h7F/PiIBc3B2qFzzAzCrUS2Zs8tSGFCd2sA6OiNLpCioeacwwVGwylav pA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t0gk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Apr 2022 15:10:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 232F6Yli021084;
        Sat, 2 Apr 2022 15:10:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx19p8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Apr 2022 15:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jk0s+Bd6/DsVx5shMRAdS+cPmL8z+PrxFaUbKhLg6Xu9NRHbYQbipZsZmFUgY+w+D0TjGtBlIvK1S1VgAiBChOs+flgkaTNRdIopDYMh0arktRPGwRkOD3aof4jQllpWc+Zx9p55h//OJnjVY2KHGPLkPgTyou4HvhtKZYoIvEKIO++a5dL5v/L92qCvXZ+tpqW8oIPEd2Bb6qRBlPGcAt0w5cYphRA5KaoHg8ecbZXrV7Nh/rHCzNSpm431lnOY/ue56b0oG1mjg0A/Az3CWmXq5DrmkYqAU9xIcSuu2ZxRlEQlEG0Msvqyqs83mSIDRWLVxZiLlPYZED2DMZhVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFurWTGhvdywxF1lx3ry4Yj5SmLgYTez1w3jG2Ufw5Q=;
 b=FROiy6+HKAxQKIcml14AnFUPaYbrtKVvnGGk3Fk/yg1W7sRKvBFEKTRs/kvNclVqLTnMS491R3HWfRs/PZDdwfa2CjvMcQRhYZLBM/fEft+4/geR4rxLFtRTUseX7fAd50w5CMNXxC3oeeuDgPc1ZLQpJ8n9sHnPuUvpZc230fY6EGKU7wRaD70NkYXnNT69wPBXgk/UNXtFZNJ73a0PgxntdDkRoDVb6lZgORzg+w8mU3+INp+/aLyyzZgC47t5F/OHQ9FreT9n2/HanGoKqcnLjxYGqRSz7KDw8fSFLFN3ILzFrRAwxVz6BeOVhEui1o5/uTJOBvIlZPpvbiG6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFurWTGhvdywxF1lx3ry4Yj5SmLgYTez1w3jG2Ufw5Q=;
 b=Nr2XYPhTV9XnXzz1OX0JYBz4imFabP2lIAJPWTPCAIeA8l7Wbpa17bdaSf1gsQE3WHjEDd0FOCzAO4cyWYSbyW4Cp5CwKRSzEn3n7L/cK4lld2ITDadnwWoX6ZmU+JlDkL6xDETqJHpkFVQzC5rrrOnAYUJ3TKPi28JzMNcQ+aY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB3938.namprd10.prod.outlook.com (2603:10b6:a03:1b2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 15:10:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::f427:92a0:da5d:7d49%6]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 15:10:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@redhat.com>
CC:     Dai Ngo <dai.ngo@oracle.com>, Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v19 0/11] NFSD: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v19 0/11] NFSD: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHYRRixSjgY1mUhNUmSFRpxQYvpLazccI2AgABMu4A=
Date:   Sat, 2 Apr 2022 15:10:08 +0000
Message-ID: <ACAE8C8A-08D3-4EC1-AB3A-FCBCD7FEC687@oracle.com>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <ed7636103eacc854f032e9cebf7e6a983ac5073e.camel@redhat.com>
In-Reply-To: <ed7636103eacc854f032e9cebf7e6a983ac5073e.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9cde80e-f1ae-4b21-4c9f-08da14bae005
x-ms-traffictypediagnostic: BY5PR10MB3938:EE_
x-microsoft-antispam-prvs: <BY5PR10MB3938742BDF86965A324260D393E39@BY5PR10MB3938.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJCigmM1PldjiBdHLfypxlqQA+66i3owc51ToIQV798R5AAX/nmhbdE6IAfI5sRrWuMIEnyqcKG4QNhd2YjR0N+231PG+ZJ36PGqEX/rrtLgXaBkX5x8rLKy2ieAxiru+V8n6j4X9WKbyLuWoeAQ/cZt234jSs0AydInk2sXKTC8kP3UUmYBM7ENbWpJd4TbAl7d9xPJNL2zVgu3j3eyrUYzX3SjxaKw1hmKLoxo+Q8Vkdx9DjboGVfMxdiRoiCNZLJXVprxTFoG5eFZmwh7cztsTycrhVfM3sbEOVojBFB9vH3Pjd9RiZfztpUoSIIzmlBpNvQX93xH/b0rQEm4g5vYX51gLu0qV9HRTEQOdM4tRkcuImjtsFvB81PVy+97Gus9A/saHWMnyGBmZum7O6z9TPzjdvT3fXE6nFExuumCsFC6N6fmvm0TWkZER5DUwp+hdeYWmioWg7Lf2v5sMLbBNx9zsXreZ63egbqaA9+ak6iMNY39UaqjXnHY8ZnmUkdVgFfx9B4x6RekNNCbLNMhbhccsi1rKwF8r28fkZ9pd9cmYVimj/x/c38ORuzNBKsf6m3je0A9ntUHizqhV7XNe6pTAS4o+N8qiM0w6GspQuVaganYthGSwx7ZIXbagrERrCXTSBZE6VNmhVQEp03719B29qxCY7wI40lovbBLnkwXnk8zn98LNDzpAD6gGui2lpz2e3ohtdwOiwFJ9ISFgKfbOuGOg1Yx9PQNm5YW5TS1VPwx3kykvEqQOfd27LIey2wCGBF7SarFvFo6RSupKUjgAoBz4T9BqWiHUCVS485TU0aMlTMQOxN2UWz0nkmnoerH3/3xJ102q/DATA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(38070700005)(26005)(30864003)(966005)(5660300002)(53546011)(54906003)(8676002)(4326008)(36756003)(6916009)(186003)(6506007)(6512007)(64756008)(66446008)(66556008)(122000001)(66946007)(83380400001)(66476007)(8936002)(91956017)(86362001)(316002)(33656002)(71200400001)(76116006)(2906002)(38100700002)(508600001)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TtecP27xobrD8diAQ2vTXuj8ityMINoPmh/tt3WukyXDyPk3b6bcvMvtirtr?=
 =?us-ascii?Q?BeFRDmnZfkU3L+SPJZIjqk6L/qEQfIqr04VAfpgDthIqlcLDX1Nn5D1HKCX5?=
 =?us-ascii?Q?l474+NJTlaBiCH3k6LuX0HsrfUs+a6GPvCZUMscTqtAcK/bBusGNpaqkaDOu?=
 =?us-ascii?Q?YrEMTeKdHajdNgSgOAta9s2GmWAL77kbhqfeaUXCZekZMIkXB3Q++IEWkl7p?=
 =?us-ascii?Q?aAOREf1vRmkMfl9D2EoaRa66RaJzz44HrH3CQHLSbzolEFNts0851ngVfyD2?=
 =?us-ascii?Q?fkFmLic1uM43ScvWY0ze3nZDVupd7y1xRIBIxvNgOarcCIzTd4xf/Uhwl1zk?=
 =?us-ascii?Q?o2Fu4hwMdTA3r81eEKAp0DfOWTVwn+YOzb5c1zhxSSOAslFVYNGbOdAyCGfd?=
 =?us-ascii?Q?zoYm6ZnF40fFwKUjX5VnADhOx9/ZVtXKzMr9b0uzzyreBWnOvVWhQSklzoFo?=
 =?us-ascii?Q?8x/nOBvwYjQ9ldSp68uWOPf33xnmcEuWDpHuBfoNF09HhhxaAgEqN2MADBch?=
 =?us-ascii?Q?vaKYAKRWnhpHvEVxq8RdAY4BQRRLV8bPfKTTxdG/Fn9T657GNJ+0fHz0F0iA?=
 =?us-ascii?Q?KU+fYlqxOU4gsHVh7WhtfJsIJvSDTK6b8A45+rJsbsNWH2Gsnz3JJ2Ki/sDE?=
 =?us-ascii?Q?Zd2OSmilJDjYOiX8GSeuUjqVneJvbKVIxXWBW5bLflR4Mq6AjIvoSn67TqG0?=
 =?us-ascii?Q?z+i3Lwd1JX4nulQ25/5nCx6m6F3QtexjMpqD07m2vMxv575pAHkNCdhh77Z0?=
 =?us-ascii?Q?bkCH4EZ4HXYFMyv9aQEgE5X5lfo6Ky7IRJ+TzNS4Tkmi3EY0AAjEuBtDrKkM?=
 =?us-ascii?Q?GpeiDG4tUp3OyYMjHLQQI/l04eB0HWgpHsUXWXhZMgFB8zYqirt43dfXYo1e?=
 =?us-ascii?Q?YBAloufdUW0OUBaTPMLsl1LYSd8VsR1JRkTkvrGKX7IFlPaXGb49I2dinuMJ?=
 =?us-ascii?Q?b6BdZkQrxA1v65mtgI13mVXqCyzxhzy5w6d0gEJZ5pQzpVLAkrfvvAr8qmdp?=
 =?us-ascii?Q?U60pSBOQ67eXeeC0MlU741rDF+5PZlq+Za0mDhI3tUaXcSeWc/OdoUnYBFyf?=
 =?us-ascii?Q?2YX8NVdmBWCjxYoIZqY+XHq7MsoHiQ0mRgcvzz8ib9ThsK8WE3bL76SlqXJ7?=
 =?us-ascii?Q?TWIvxnjwoN2wzefKtWxqy8zbQq20MoKeoW0IINPiF7Yxk8jBNlrr508PETBs?=
 =?us-ascii?Q?IVt5UYF84hBwSwKyB/NCDwf7ZHAmd25wrOdK27xaozOH6d5ntKH22PcMu2tg?=
 =?us-ascii?Q?J7BFFHS4dyj1unP7hotXPTp0kaPcQXiB0gjlKo/ZcdoprGSaCZoI3ULK366H?=
 =?us-ascii?Q?wv3SDtT2ulC7QEDNf2N0QDrL1CBGs3iym6i6ug8K44WLGZO5l150G50hZogn?=
 =?us-ascii?Q?RUULr7qM04Dmt6Ne/Ph6YvULuL+9t/3eBUjs/kwKanIZlyeoIeS9/Lta7vcJ?=
 =?us-ascii?Q?Uu9Q+MTpUP14iglErFe+8iyWE4zy/UxPlXTnmAamYfwRd5xLIsfb6coXNJM2?=
 =?us-ascii?Q?90ZVOt+NHO4ppVY7k19JgrpjidKsUDdTO+On4Y4FaDt4vSpH2hUIyWms7WDs?=
 =?us-ascii?Q?YP5lNdv6BzHwpPNI37WWaeUtE3tA+7aKNL04h5c6iOtOCf7ouyDFJkLM50aw?=
 =?us-ascii?Q?ayiSUCdOjY8w6qd/HchCt33yFXqD5AlC8Zcg9TWSn5R/ywLfOZje2XXIYpZY?=
 =?us-ascii?Q?Vn5T0uJCQxXvoIwRbGXxtJm4SN7ZK5p6saqA2+10bm5XxRquh7EMBuH206tc?=
 =?us-ascii?Q?KzeQq9w7R9UDoyj/GfF5pWAlTVg3BO4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E7BAAB61A21B44281F3EE076DAC7C20@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cde80e-f1ae-4b21-4c9f-08da14bae005
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 15:10:08.0481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOLCdKUw1v4T5b5gNh2LZK20lK8ONpZYPB7TXZ43IcR4qicgqLxRoPtBNRJ2e8cAzYy9L7NuX18tsuM3vcKa4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3938
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-02_05:2022-03-30,2022-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204020096
X-Proofpoint-ORIG-GUID: H0OZxRM4U2xxH3Oi4Z0IbCe3YqNcB60B
X-Proofpoint-GUID: H0OZxRM4U2xxH3Oi4Z0IbCe3YqNcB60B
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 2, 2022, at 6:35 AM, Jeff Layton <jlayton@redhat.com> wrote:
>=20
> On Thu, 2022-03-31 at 09:01 -0700, Dai Ngo wrote:
>> Hi Chuck, Bruce
>>=20
>> This series of patches implement the NFSv4 Courteous Server.
>>=20
>> A server which does not immediately expunge the state on lease expiratio=
n
>> is known as a Courteous Server.  A Courteous Server continues to recogni=
ze
>> previously generated state tokens as valid until conflict arises between
>> the expired state and the requests from another client, or the server
>> reboots.
>>=20
>> v2:
>>=20
>> . add new callback, lm_expire_lock, to lock_manager_operations to
>>  allow the lock manager to take appropriate action with conflict lock.
>>=20
>> . handle conflicts of NFSv4 locks with NFSv3/NLM and local locks.
>>=20
>> . expire courtesy client after 24hr if client has not reconnected.
>>=20
>> . do not allow expired client to become courtesy client if there are
>>  waiters for client's locks.
>>=20
>> . modify client_info_show to show courtesy client and seconds from
>>  last renew.
>>=20
>> . fix a problem with NFSv4.1 server where the it keeps returning
>>  SEQ4_STATUS_CB_PATH_DOWN in the successful SEQUENCE reply, after
>>  the courtesy client reconnects, causing the client to keep sending
>>  BCTS requests to server.
>>=20
>> v3:
>>=20
>> . modified posix_test_lock to check and resolve conflict locks
>>  to handle NLM TEST and NFSv4 LOCKT requests.
>>=20
>> . separate out fix for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>=20
>> v4:
>>=20
>> . rework nfsd_check_courtesy to avoid dead lock of fl_lock and client_lo=
ck
>>  by asking the laudromat thread to destroy the courtesy client.
>>=20
>> . handle NFSv4 share reservation conflicts with courtesy client. This
>>  includes conflicts between access mode and deny mode and vice versa.
>>=20
>> . drop the patch for back channel stuck in SEQ4_STATUS_CB_PATH_DOWN.
>>=20
>> v5:
>>=20
>> . fix recursive locking of file_rwsem from posix_lock_file.=20
>>=20
>> . retest with LOCKDEP enabled.
>>=20
>> v6:
>>=20
>> . merge witn 5.15-rc7
>>=20
>> . fix a bug in nfs4_check_deny_bmap that did not check for matched
>>  nfs4_file before checking for access/deny conflict. This bug causes
>>  pynfs OPEN18 to fail since the server taking too long to release
>>  lots of un-conflict clients' state.
>>=20
>> . enhance share reservation conflict handler to handle case where
>>  a large number of conflict courtesy clients need to be expired.
>>  The 1st 100 clients are expired synchronously and the rest are
>>  expired in the background by the laundromat and NFS4ERR_DELAY
>>  is returned to the NFS client. This is needed to prevent the
>>  NFS client from timing out waiting got the reply.
>>=20
>> v7:
>>=20
>> . Fix race condition in posix_test_lock and posix_lock_inode after
>>  dropping spinlock.
>>=20
>> . Enhance nfsd4_fl_expire_lock to work with with new lm_expire_lock
>>  callback
>>=20
>> . Always resolve share reservation conflicts asynchrously.
>>=20
>> . Fix bug in nfs4_laundromat where spinlock is not used when
>>  scanning cl_ownerstr_hashtbl.
>>=20
>> . Fix bug in nfs4_laundromat where idr_get_next was called
>>  with incorrect 'id'.=20
>>=20
>> . Merge nfs4_destroy_courtesy_client into nfsd4_fl_expire_lock.
>>=20
>> v8:
>>=20
>> . Fix warning in nfsd4_fl_expire_lock reported by test robot.
>>=20
>> v9:
>>=20
>> . Simplify lm_expire_lock API by (1) remove the 'testonly' flag
>>  and (2) specifying return value as true/false to indicate
>>  whether conflict was succesfully resolved.
>>=20
>> . Rework nfsd4_fl_expire_lock to mark client with
>>  NFSD4_DESTROY_COURTESY_CLIENT then tell the laundromat to expire
>>  the client in the background.
>>=20
>> . Add a spinlock in nfs4_client to synchronize access to the
>>  NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT flag to
>>  handle race conditions when resolving lock and share reservation
>>  conflict.
>>=20
>> . Courtesy client that was marked as NFSD4_DESTROY_COURTESY_CLIENT
>>  are now consisdered 'dead', waiting for the laundromat to expire
>>  it. This client is no longer allowed to use its states if it
>>  reconnects before the laundromat finishes expiring the client.
>>=20
>>  For v4.1 client, the detection is done in the processing of the
>>  SEQUENCE op and returns NFS4ERR_BAD_SESSION to force the client
>>  to re-establish new clientid and session.
>>  For v4.0 client, the detection is done in the processing of the
>>  RENEW and state-related ops and return NFS4ERR_EXPIRE to force
>>  the client to re-establish new clientid.
>>=20
>> v10:
>>=20
>>  Resolve deadlock in v9 by avoiding getting cl_client and
>>  cl_cs_lock together. The laundromat needs to determine whether
>>  the expired client has any state and also has no blockers on
>>  its locks. Both of these conditions are allowed to change after
>>  the laundromat transits an expired client to courtesy client.
>>  When this happens, the laundromat will detect it on the next
>>  run and and expire the courtesy client.
>>=20
>>  Remove client persistent record before marking it as COURTESY_CLIENT
>>  and add client persistent record before clearing the COURTESY_CLIENT
>>  flag to allow the courtesy client to transist to normal client to
>>  continue to use its state.
>>=20
>>  Lock/delegation/share reversation conflict with courtesy client is
>>  resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
>>  effectively disable it, then allow the current request to proceed
>>  immediately.
>>=20
>>  Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed
>>  to reconnect to reuse itsstate. It is expired by the laundromat
>>  asynchronously in the background.
>>=20
>>  Move processing of expired clients from nfs4_laudromat to a
>>  separate function, nfs4_get_client_reaplist, that creates the
>>  reaplist and also to process courtesy clients.
>>=20
>>  Update Documentation/filesystems/locking.rst to include new
>>  lm_lock_conflict call.
>>=20
>>  Modify leases_conflict to call lm_breaker_owns_lease only if
>>  there is real conflict.  This is to allow the lock manager to
>>  resolve the delegation conflict if possible.
>>=20
>> v11:
>>=20
>>  Add comment for lm_lock_conflict callback.
>>=20
>>  Replace static const courtesy_client_expiry with macro.
>>=20
>>  Remove courtesy_clnt argument from find_in_sessionid_hashtbl.
>>  Callers use nfs4_client->cl_cs_client boolean to determined if
>>  it's the courtesy client and take appropriate actions.
>>=20
>>  Rename NFSD4_COURTESY_CLIENT and NFSD4_DESTROY_COURTESY_CLIENT
>>  with NFSD4_CLIENT_COURTESY and NFSD4_CLIENT_DESTROY_COURTESY.
>>=20
>> v12:
>>=20
>>  Remove unnecessary comment in nfs4_get_client_reaplist.
>>=20
>>  Replace nfs4_client->cl_cs_client boolean with
>>  NFSD4_CLIENT_COURTESY_CLNT flag.
>>=20
>>  Remove courtesy_clnt argument from find_client_in_id_table and
>>  find_clp_in_name_tree. Callers use NFSD4_CLIENT_COURTESY_CLNT to
>>  determined if it's the courtesy client and take appropriate actions.
>>=20
>> v13:
>>=20
>>  Merge with 5.17-rc3.
>>=20
>>  Cleanup Documentation/filesystems/locking.rst: replace i_lock
>>  with flc_lock, update API's that use flc_lock.
>>=20
>>  Rename lm_lock_conflict to lm_lock_expired().
>>=20
>>  Remove comment of lm_lock_expired API in lock_manager_operations.
>>  Same information is in patch description.
>>=20
>>  Update commit messages of 4/4.
>>=20
>>  Add some comment for NFSD4_CLIENT_COURTESY_CLNT.
>>=20
>>  Add nfsd4_discard_courtesy_clnt() to eliminate duplicate code of
>>  discarding courtesy client; setting NFSD4_DESTROY_COURTESY_CLIENT.
>>=20
>> v14:
>>=20
>> . merge with Chuck's public for-next branch.
>>=20
>> . remove courtesy_client_expiry, use client's last renew time.
>>=20
>> . simplify comment of nfs4_check_access_deny_bmap.
>>=20
>> . add comment about race condition in nfs4_get_client_reaplist.
>>=20
>> . add list_del when walking cslist in nfs4_get_client_reaplist.
>>=20
>> . remove duplicate INIT_LIST_HEAD(&reaplist) from nfs4_laundromat
>>=20
>> . Modify find_confirmed_client and find_confirmed_client_by_name
>>  to detect courtesy client and destroy it.
>>=20
>> . refactor lookup_clientid to use find_client_in_id_table
>>  directly instead of find_confirmed_client.
>>=20
>> . refactor nfsd4_setclientid to call find_clp_in_name_tree
>>  directly instead of find_confirmed_client_by_name.
>>=20
>> . remove comment of NFSD4_CLIENT_COURTESY.
>>=20
>> . replace NFSD4_CLIENT_DESTROY_COURTESY with NFSD4_CLIENT_EXPIRED.
>>=20
>> . replace NFSD4_CLIENT_COURTESY_CLNT with NFSD4_CLIENT_RECONNECTED.
>>=20
>> v15:
>>=20
>> . add helper locks_has_blockers_locked in fs.h to check for
>>  lock blockers
>>=20
>> . rename nfs4_conflict_clients to nfs4_resolve_deny_conflicts_locked
>>=20
>> . update nfs4_upgrade_open() to handle courtesy clients.
>>=20
>> . add helper nfs4_check_and_expire_courtesy_client and
>>  nfs4_is_courtesy_client_expired to deduplicate some code.
>>=20
>> . update nfs4_anylock_blocker:
>>   . replace list_for_each_entry_safe with list_for_each_entry
>>   . break nfs4_anylock_blocker into 2 smaller functions.
>>=20
>> . update nfs4_get_client_reaplist:
>>   . remove unnecessary commets
>>   . acquire cl_cs_lock before setting NFSD4_CLIENT_COURTESY flag
>>=20
>> . update client_info_show to show 'time since last renew: 00:00:38'
>>  instead of 'seconds from last renew: 38'.
>>=20
>> v16:
>>=20
>> . update client_info_show to display 'status' as
>>  'confirmed/unconfirmed/courtesy'
>>=20
>> . replace helper locks_has_blockers_locked in fs.h in v15 with new
>>  locks_owner_has_blockers call in fs/locks.c
>>=20
>> . update nfs4_lockowner_has_blockers to use locks_owner_has_blockers
>>=20
>> . move nfs4_check_and_expire_courtesy_client from 5/11 to 4/11
>>=20
>> . remove unnecessary check for NULL clp in find_in_sessionid_hashtb
>>=20
>> . fix typo in commit messages
>>=20
>> v17:
>>=20
>> . replace flags used for courtesy client with enum courtesy_client_state
>>=20
>> . add state table in nfsd/state.h
>>=20
>> . make nfsd4_expire_courtesy_clnt, nfsd4_discard_courtesy_clnt and
>>  nfsd4_courtesy_clnt_expired as static inline.
>>=20
>> . update nfsd_breaker_owns_lease to use dl->dl_stid.sc_client directly
>>=20
>> . fix kernel test robot warning when CONFIG_FILE_LOCKING not defined.
>>=20
>> v18:
>>=20
>> . modify 0005-NFSD-Update-nfs4_get_vfs_file-to-handle-courtesy-cli.patch=
 to:
>>=20
>>    . remove nfs4_check_access_deny_bmap, fold this functionality
>>      into nfs4_resolve_deny_conflicts_locked by making use of
>>      bmap_to_share_mode.
>>=20
>>    . move nfs4_resolve_deny_conflicts_locked into nfs4_file_get_access
>>      and nfs4_file_check_deny.=20
>>=20
>> v19:
>>=20
>> . modify 0002-NFSD-Add-courtesy-client-state-macro-and-spinlock-to.patch=
 to
>>=20
>>    . add NFSD4_CLIENT_ACTIVE
>>=20
>>    . redo Courtesy client state table
>>=20
>> . modify 0007-NFSD-Update-find_in_sessionid_hashtbl-to-handle-cour.patch=
 and
>>  0008-NFSD-Update-find_client_in_id_table-to-handle-courte.patch to:
>>=20
>>    . set cl_cs_client_stare to NFSD4_CLIENT_ACTIVE when reactive
>>      courtesy client =20
>>=20
>>=20
>=20
> Dai,
>=20
> Do you have a public tree with these patches?

I've been hosting them here:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/

in the nfsd-courteous-server branch.


--
Chuck Lever



