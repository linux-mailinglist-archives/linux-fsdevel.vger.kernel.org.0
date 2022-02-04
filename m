Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538144A9BEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 16:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359678AbiBDPZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Feb 2022 10:25:17 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15546 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233188AbiBDPZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:25:17 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214F46Wl011348;
        Fri, 4 Feb 2022 15:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ddZNZCHuWkQfZT2yYIuX+719Zw5UTuUTo1b2HfSXy9U=;
 b=NPTREWYtlDujistUid/+Tm6TzjqRc+Yb8p2+fkPPbojXmtkoxZVlYxfumOWs31PeMNP9
 I5Ses7QJE5Y7Qdd1lwOAI4J3YPwJYRbLqpgiNuakZ8IDQLZNM55Eqml/PMnNoDbxN990
 0QhTYwcw/PNf4Cyf2DJBn0Dk1rR/K+hga0BYkwe/5/3Gf6GiBDt+HuFgCj2cCyyBnQKb
 PJ1TLKtk+Sqe5Zj2vtp7slzH1mfQo3EnYpSDciwZMnqaBGKPJAkxtipJu1tWJ74SBEfH
 9dD7jHRaqgtwDkHvSLpSndMCnSZgHwrNbpNtNPA9YovIUHfYnpRNGKkFEqS14grL13lp vQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hevu0tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 15:25:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214FFper000757;
        Fri, 4 Feb 2022 15:25:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3030.oracle.com with ESMTP id 3dvumnn1j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 15:25:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KM4yaAF/+rTQbYQBN/qdUPkt+XEQ9faUe1SNYHZs6Vtz/Va7cSGW3CeWFVJG+Ftn4Vi5U1wjAQPtqHuTPxZhCBVzbJJzbrOBcKz3F+xy+G+axqIlH7ExFXeFouBXALbxjdapip3ZMnAEWdnzHsAcyJWsZKGHdNHPoFAxZBwjVJyGi2rr2CyRvjdjYHQTvYZF4oBBceO8GVvK2CguDEAeKvSfxECmwl8upTHfPweMWL8eCDpmraFsL6/FlyzMbnYD9/kJSVS7vz7yQP+Yn/VAfRTHkaK9LxAwmweGiTVsl8HonumHXDJ9mxCB2nKYyZw5Mj90OGmdTnzrHd/jO/yEew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddZNZCHuWkQfZT2yYIuX+719Zw5UTuUTo1b2HfSXy9U=;
 b=E+T3icXd199UeR26qyrrn0Z2OvJCSO/M2ELyftMuo+phqD6WcbWKNhh4TvdoRqrhpkxcgRO+vkgcYHAjYDe5adv4Oi8F65JhOIdsAwF+CZzOqLoFJ25it/+TFYPXalLLn3ZaQuYkCfDAItiWgNedGbCcBYGM1HJ8WQiK66D633kM27i+IK1YVp9V0hFTtcXTKZeGPpdD4Ig3Dos1K2IPXlJ7PXElZY9LNw0wPBPBpLpu/hOQb6w9v1EhcUKvBPfbvrLaKFv8cTpHT0OwGS+O28KIxSH9r3Tq6adUE8mCeWL6ZFEfNIdeOUWOa+keDjSlpd+ELI7dxiRCast3Xvfq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddZNZCHuWkQfZT2yYIuX+719Zw5UTuUTo1b2HfSXy9U=;
 b=CfVmp7ckBzvpgCAu5zbJRAYYjuD724ogZadmW3yWimwAO6Q480uOytkPu2cJtQqYhcMDWuy4MUd5rYGEo8HnC0TFAnBA+ua98wi1XgXrK8xd3yQqk06soSxNit0/JoweEreF5WA1ymhb05/QEkR+j423dqk8IHksIKUnfbJxZvw=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 DM5PR1001MB2250.namprd10.prod.outlook.com (2603:10b6:4:2b::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.21; Fri, 4 Feb 2022 15:25:11 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00%5]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 15:25:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 3/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Topic: [PATCH RFC 3/3] nfsd: Initial implementation of NFSv4 Courteous
 Server
Thread-Index: AQHYFH7X1sEKJuZpaUeYDd9pPdXaRKyCQCmAgAAjwYCAACHnAIAAQ5OAgADEaQA=
Date:   Fri, 4 Feb 2022 15:25:11 +0000
Message-ID: <1C0AD92E-900C-4F47-9255-A50CE184F241@oracle.com>
References: <1643398773-29149-1-git-send-email-dai.ngo@oracle.com>
 <1643398773-29149-4-git-send-email-dai.ngo@oracle.com>
 <3A7DD587-0511-4F04-AE9A-41595BA421F4@oracle.com>
 <9abcb71b-6a1b-941d-5125-c812a13b549e@oracle.com>
 <36731CD8-E35E-436F-AF1A-9F97C0ADCA57@oracle.com>
 <36d579fa-8d7b-113c-704a-479b7365173b@oracle.com>
In-Reply-To: <36d579fa-8d7b-113c-704a-479b7365173b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bb3e543-0957-4649-b909-08d9e7f28903
x-ms-traffictypediagnostic: DM5PR1001MB2250:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB22506A2222A6C444F5BAC99E93299@DM5PR1001MB2250.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FJxxxbEmchTdpqr7PIjU5AOERM5Z4jHHMfOcYgyMYBOblmaDuuXmfJulQ1IrlH93fa1o025UdCkIyNp/BKEiDTMBPtZXNMMhilHsVDwE18foDmRAycBGVCzL/0pZT1tHzWgMvCGS6NgKQBB7gKribJ/ZBW6V2okBHkZtotxDf5Pufmy8kvQqAGDNpqxHjQicgpWkDlCbOO+4ZHyeBPuu27l1t6Zqsss9NXlguxck5odp3UcWDInc5K1e9AILDOSIdBKtdnNhOpbHHGCtnMLB8A9u0Zu1O5RbOu0yCPYllU7P/EKrhZkU2Jw8IUmUIrXLkytXO4QsN5RhhZhunZFEiWgsvQdGhrZwTLYfaVDzXeDhTRc1lruucUThrY4A+JC/gqDxT8rtOF6R3s98FQTX7sWDvhtFkDLuzNKYDrSfZ4l2w1wcX7qO3OUn3eFr5Wc0cR2vsJoTsDeB0z2qOTaAhmMSDA64NXquqA610Sr0hrJb++tbmJNxE/TZcI4CGwMJqSSvx4UGe/J3PVYPTWEp9IOyvxzkoVXlvD7mdE4Cv4aKnVSpUPDNlUcBQj4rO9t8+z5m8Q19oTE83Uu2PI30Gp3O5rgU9j6MOmBT7zp6C6wqT7492ib6xSjkEbzNdNaaExUe8XnnP9VGVJtF20GPfGRzpK3Yn7SsFdDF9l9MvJoHcr+svKe3vnsEe0HBzU8qg49feOOhegkecbvxfgu1cazbkGRQkjpoxccfYnWp5XY5s6dY+B6+NfJCss5zU6Sn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(6506007)(26005)(316002)(122000001)(53546011)(37006003)(33656002)(38100700002)(54906003)(71200400001)(6636002)(2906002)(36756003)(66476007)(5660300002)(508600001)(66556008)(38070700005)(6486002)(6862004)(66446008)(91956017)(76116006)(2616005)(8936002)(66946007)(64756008)(6512007)(4326008)(86362001)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?smGf6jXt5MKvxui//3Ioh5ldeE8gBrVW4j93WIehPkbauW4bR05tsX0nMK1P?=
 =?us-ascii?Q?lUnHtdqluJH8HaK913pz1dk+DemC+/BJjZpHhAE30/8Yq1CYhoW7rsmmb5bj?=
 =?us-ascii?Q?CeVh6jcoZ/pGkXR/li46jNJ0b7plDiw7vCWV++vQnoaBPueofEI3s7/zsXXy?=
 =?us-ascii?Q?agXa78rZ60fXtK1psdJTxDPglGXsfvzBp60TUamuM25f/sWtrlI8aSXhDEff?=
 =?us-ascii?Q?kNUIndwyoTAl2G4/9MS5h3kpHdAtgIdOGcWFTQFinyLiKRM1lTsbXd+aGpPo?=
 =?us-ascii?Q?76Wp13GAJcBmJtFSSCUD2NzoT/f661mbo6mp2sIjqmXSli3tqpgD5cnXtWrp?=
 =?us-ascii?Q?odnSsXMSWn9Q9E9fU5F2D8Uq91lzlVgkmFA3ddG2G7B+tjo7EhGxJf8uJv1t?=
 =?us-ascii?Q?+IhoJe/JHsLvKSUEffp2DAea92QMdStrH5B9KbOLYPebVHiVDGUvzAkpCeOc?=
 =?us-ascii?Q?kDux773Rl6iS/fcXWGGQ703FH2KIfEJSO8n6fHEK10OUoRpsmfdRB1MkEn3i?=
 =?us-ascii?Q?LIntaelxiBkNMEpCN+JPfx+MIlxCRzoAmOlrNF6KhHCoRt9Bx7Tul3qhYI0s?=
 =?us-ascii?Q?uMAphASWPMNSapYHeaeXlIBPQVTPohIZgct8UgvozHrIrG5nLRQOKWxIIE58?=
 =?us-ascii?Q?VyE4tAFCWUckXxpM/BJLFAlhxtk+AsRDy17DlAxf5l56hDlnvueFrGjSjnfg?=
 =?us-ascii?Q?WjBSI/yZ2AE3Lm2iHu8xvvEk6tVy1/n7bWxSpe2zLq+dqXw4py7suNFX2EOk?=
 =?us-ascii?Q?2vigssQnjXHvnyN8hit+05jzBXLQsfSxxB7+WKUNG8ZQta8YzogGRP2KVL/J?=
 =?us-ascii?Q?JJB6HXGwVCn8HrmBxOEYbRpIaMlPOhWW46YN7qsemrIaqqcocZuRnq1YhUuQ?=
 =?us-ascii?Q?OhEhWGg4tWQ/WcJPdhpUqBL7dPR7Qi0Cdj704aigzNTTGpgO1fiXtPsGn4PL?=
 =?us-ascii?Q?VPnf1pBIwFdIgIXMPcXEifIRTsB+XJyzunkUOl5q7AgdJ3y6i2wopldePvJt?=
 =?us-ascii?Q?01DZO+kB8LTvAScTFpJpdZudKuEBgdUx/NSv3X6DCAr3h7J1U3sdv9hR9aik?=
 =?us-ascii?Q?qhswhUGaQg6yHdXLQzVYxflXrTDNXHAahF6vV+32CwuHPIS5YjTa2sq6pS8z?=
 =?us-ascii?Q?WnQNFu9Du6b4F9q88pxY/ERtWn8xvlIqs/35JgOO0Gd4w0Ya/Vt57S1/LHdd?=
 =?us-ascii?Q?zbIrz1HkSvhnM4cti3vKAQUZwTEhbrBK27G5Z+ia/dumH1xMIaqrTlSktwxa?=
 =?us-ascii?Q?FBXlW3ac3psH5qDd3dt+j/hD4/NNjgNNzx56vhiRBeoGQLy6rm26mWFvYPwx?=
 =?us-ascii?Q?Yey47JWEHeRFFyndemSIgV4cHnn806UVtUzqnfmdnB4xv9GYq1gWgMM7qrJZ?=
 =?us-ascii?Q?KPwo66GBf2Ovfkeh1m5+En9PlfwyvkE++6vP2ztBVbNEevStTmAvkO2aswuB?=
 =?us-ascii?Q?0u1pjIX/c1YMWVCCVff6QWal8pVl0dl/t1WAd7M4cNFVQw4a9DQceMoWHzqU?=
 =?us-ascii?Q?fOjvINWjKRFDq6QCb1xTm04pkHaTekXU+6KX4/RwNOA+66kbE42gBmqnnVL6?=
 =?us-ascii?Q?+Zvf2b+G7gbhL4lxMbdrw/U+QIfRr3UXZsWZqH/Ow24VhtATnKZNOEIFAlfw?=
 =?us-ascii?Q?gYqfQoen02GJfyysIpiYdP8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EF222340163A2E4185E23CF2D34F7B0D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb3e543-0957-4649-b909-08d9e7f28903
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 15:25:11.4898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qR5DiynMZarBd3bKkzRvI8AO3eWSAgCJFqou/y+ssHWbKSFYt9hB3t9UY5915YMctLJJ10+E7YcDI+mVQKTwEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2250
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10247 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040087
X-Proofpoint-GUID: umONC_z9vOo9xrQZn3E5EJpO-l5B6D37
X-Proofpoint-ORIG-GUID: umONC_z9vOo9xrQZn3E5EJpO-l5B6D37
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 3, 2022, at 10:42 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
>=20
> On 2/3/22 3:40 PM, Chuck Lever III wrote:
>>=20
>>> On Feb 3, 2022, at 4:38 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>=20
>>>=20
>>> On 2/3/22 11:31 AM, Chuck Lever III wrote:
>>>>> On Jan 28, 2022, at 2:39 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>>>=20
>>>>> Currently an NFSv4 client must maintain its lease by using the at lea=
st
>>>>> one of the state tokens or if nothing else, by issuing a RENEW (4.0),=
 or
>>>>> a singleton SEQUENCE (4.1) at least once during each lease period. If=
 the
>>>>> client fails to renew the lease, for any reason, the Linux server exp=
unges
>>>>> the state tokens immediately upon detection of the "failure to renew =
the
>>>>> lease" condition and begins returning NFS4ERR_EXPIRED if the client s=
hould
>>>>> reconnect and attempt to use the (now) expired state.
>>>>>=20
>>>>> The default lease period for the Linux server is 90 seconds.  The typ=
ical
>>>>> client cuts that in half and will issue a lease renewing operation ev=
ery
>>>>> 45 seconds. The 90 second lease period is very short considering the
>>>>> potential for moderately long term network partitions.  A network par=
tition
>>>>> refers to any loss of network connectivity between the NFS client and=
 the
>>>>> NFS server, regardless of its root cause.  This includes NIC failures=
, NIC
>>>>> driver bugs, network misconfigurations & administrative errors, route=
rs &
>>>>> switches crashing and/or having software updates applied, even down t=
o
>>>>> cables being physically pulled.  In most cases, these network failure=
s are
>>>>> transient, although the duration is unknown.
>>>>>=20
>>>>> A server which does not immediately expunge the state on lease expira=
tion
>>>>> is known as a Courteous Server.  A Courteous Server continues to reco=
gnize
>>>>> previously generated state tokens as valid until conflict arises betw=
een
>>>>> the expired state and the requests from another client, or the server
>>>>> reboots.
>>>>>=20
>>>>> The initial implementation of the Courteous Server will do the follow=
ing:
>>>>>=20
>>>>> . When the laundromat thread detects an expired client and if that cl=
ient
>>>>> still has established state on the Linux server and there is no waite=
rs
>>>>> for the client's locks then deletes the client persistent record and =
marks
>>>>> the client as COURTESY_CLIENT and skips destroying the client and all=
 of
>>>>> state, otherwise destroys the client as usual.
>>>>>=20
>>>>> . Client persistent record is added to the client database when the
>>>>> courtesy client reconnects and transits to normal client.
>>>>>=20
>>>>> . Lock/delegation/share reversation conflict with courtesy client is
>>>>> resolved by marking the courtesy client as DESTROY_COURTESY_CLIENT,
>>>>> effectively disable it, then allow the current request to proceed
>>>>> immediately.
>>>>>=20
>>>>> . Courtesy client marked as DESTROY_COURTESY_CLIENT is not allowed to
>>>>> reconnect to reuse itsstate. It is expired by the laundromat asynchro=
nously
>>>>> in the background.
>>>>>=20
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>> fs/nfsd/nfs4state.c | 454 +++++++++++++++++++++++++++++++++++++++++++=
++++-----
>>>>> fs/nfsd/state.h     |   5 +
>>>>> 2 files changed, 415 insertions(+), 44 deletions(-)
>>>>>=20
>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>> index 1956d377d1a6..b302d857e196 100644
>>>>> --- a/fs/nfsd/nfs4state.c
>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>> @@ -1913,14 +1915,37 @@ __find_in_sessionid_hashtbl(struct nfs4_sessi=
onid *sessionid, struct net *net)
>>>>>=20
>>>>> static struct nfsd4_session *
>>>>> find_in_sessionid_hashtbl(struct nfs4_sessionid *sessionid, struct ne=
t *net,
>>>>> -		__be32 *ret)
>>>>> +		__be32 *ret, bool *courtesy_clnt)
>>>> IMO the new @courtesy_clnt parameter isn't necessary.
>>>> Just create a new cl_flag:
>>>>=20
>>>> +#define NFSD4_COURTESY_CLIENT		(6)	/* be nice to expired client */
>>>> +#define NFSD4_DESTROY_COURTESY_CLIENT	(7)
>>>>=20
>>>> #define NFSD4_CLIENT_PROMOTE_COURTESY   (8)
>>>>=20
>>>> or REHYDRATE_COURTESY some such.
>>>>=20
>>>> Set that flag and check it once it is safe to call
>>>> nfsd4_client_record_create().
>>> We need the 'courtesy_clnt' parameter so caller can specify
>>> whether the courtesy client should be promoted or not.
>> I understand what the flag is used for in the patch, but I
>> prefer to see this implemented without changing the synopsis
>> of all those functions. Especially adding an output parameter
>> like this is usually frowned upon.
>>=20
>> The struct nfs_client can carry this flag, if not in cl_flags,
>> then perhaps in another field. That struct is visible in every
>> one of the callers.
>=20
> The struct nfs4_client is not available to the caller of
> find_in_sessionid_hashtbl at the time it calls the function and
> the current input parameters of find_in_sessionid_hashtbl can
> not be used to specify this flag.

I see three callers of find_in_sessionid_hashtbl():

- nfsd4_bind_conn_to_session
- nfsd4_destroy_session
- nfsd4_sequence

In none of these callers is the courtesy_clnt variable set
to a true or false value _before_ find_in_sessionid_hashtbl()
is called. AFAICT, @courtesy_clnt is an output-only parameter.

The returned @session::se_client field points to a client
that can be examined to see if it has been promoted back to
active status.

--
Chuck Lever



