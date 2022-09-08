Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7375B236E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 18:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbiIHQQe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbiIHQPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:15:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0B176747;
        Thu,  8 Sep 2022 09:15:35 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288G4WUd028471;
        Thu, 8 Sep 2022 16:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=qomBej2s0b6urJJ4I/GsWj1SBaGb9q8nKM5oXreR5vg=;
 b=aPoaCiyzPJEvqWdg6Q3OeIt4SjF8zky/bElGPxkeq6fQCTtddd1EkUoGGxwvXfkJeXnE
 bJR4h7VR0WOYflyGkTlWxADwDSIDOa4iKPuwR40W4dPa0M1KuTygEBPKFST+OFNTx/m1
 N9gie4Hp2fW6+pMd5ezMAmFNDd6sNAQYWpre/iL3wL5lbvzSrHsIu1IczbehMRpQwfpe
 RDqiD0YbUkyuKZ8KCAqGFeacQz+xJfzC/pVJFQQFplk7qfuxeK0fHypzub6Z2cBu9pj9
 +TU+UhdZnRrJvmpWeMi9i4+cmkhMw270UB7wpfO29nfVU/smGXunr8WMmzgdT1vtWFCs bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftve43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 16:15:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288FS7ee028089;
        Thu, 8 Sep 2022 16:15:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcc6yw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 16:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkxQOchWOfR/9AHF/43/oACZEAKLs7sGX8H4CIgNtNsMQOy8vmJClNwPMelPz2+08qozeBCg1ifVffDPaiG+abAQ9ecvWWccADsKzJ62ZgtY/QUgoex9vF5krZ+ygg5o/PEQ0OIXk9ZK47NULc+k1oitFfHHIk0HwWfpRr8vWr2k9yBig2u6iveGAbatbzoifBkg0xyruM52ZPzVDD3f8pifmqiDFaON79Y9OZFKZlCz4uzLgegJnfSH/drC3CI1buFCfFMxxr2wsILmaslSkctX9uwYboAifWzbycJPw5oa+mT8I7zW7QhhoEJwnKP63jupf6Sn18JFDXDQnqkNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qomBej2s0b6urJJ4I/GsWj1SBaGb9q8nKM5oXreR5vg=;
 b=Sqb0TYUToHsC6ghMydW33q3JM+RMSo/83j4fFznLJLW0+nD5854NryEsvfYTLOl0KOMlDx7Yn/EuTyvR7dYGa0MS0oIvrbWljwpHxQBYNHfPQRiUt+T1dpjYEF2320MyCzAeIdEnyPZQovgaU5iyTpblg3QSN5fatnRI3uHOKrBLUasRoydNkpwqS4etplIx/cqJ+jR1CLlf8TVTIHMwKcqPNPoKHiPfhXF9P4h4a6dTwqSXNKxj5lurTaD/d5Z/WZEIn7QCoyqxp3keK7RGhQa2xA/idL4siDXEG032tl2LYPz1nvIJdmIk0NGTSDmB3A7jomXlrDCjGcCIsSctlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qomBej2s0b6urJJ4I/GsWj1SBaGb9q8nKM5oXreR5vg=;
 b=tfDTNSYbHdzxfEXApoo0p2x/yORms+LYgMnp8bZCMGfRq3QP0XRRxxXVp69ohMJVhVFKaPV8JoiP0/vVnycImQr94kg1hml9xSlSrQbDkybZwwMjA+j4WmyCTy4Ub0WH1i9I7DrNv2CF+84E0bd0QeVAXCRapf14SoyPKqTkfwA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH8PR10MB6338.namprd10.prod.outlook.com (2603:10b6:510:1cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 8 Sep
 2022 16:15:12 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 16:15:12 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>, Theodore Ts'o <tytso@mit.edu>
CC:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        Neil Brown <neilb@suse.de>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux-XFS <linux-xfs@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqtBEl18RH0NrEO0UKb7ApfWq63T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAAzmAgAAFVoA=
Date:   Thu, 8 Sep 2022 16:15:12 +0000
Message-ID: <03CEBF7E-649D-4BE3-B759-EA2E561B4110@oracle.com>
References: <20220907111606.18831-1-jlayton@kernel.org>
 <166255065346.30452.6121947305075322036@noble.neil.brown.name>
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>
 <20220907125211.GB17729@fieldses.org>
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>
 <20220907135153.qvgibskeuz427abw@quack3>
 <166259786233.30452.5417306132987966849@noble.neil.brown.name>
 <20220908083326.3xsanzk7hy3ff4qs@quack3> <YxoIjV50xXKiLdL9@mit.edu>
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>
 <20220908155605.GD8951@fieldses.org>
In-Reply-To: <20220908155605.GD8951@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH8PR10MB6338:EE_
x-ms-office365-filtering-correlation-id: 1c16f76d-b91d-4a1b-3736-08da91b54ec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9M+t+5c40zYcxD7QpXghATcuUl0S0DL5zFAOMhshAU8795fnCmsIhRymgp1xhl3kLJIDDR9cAU2TjSZOKYxytxHTQ/SBrhieh/3FEJQQ1+84ww6bq5x2mvh6TdvoCc8xAUoPzwBccGtGkRump1+oYDxjWFpRB2UqFeK2A38krB+Ao/Emh4ek6ifjDn9r7c5JhqWqkbtTpbk9BlZa0sdtVqJloeN2rlils9CdlS8SugrerYnqTHk02Ge1ArmL1kLyFJrBGTfq3h927CgNWy3+eK6DDqUtWilvemZPuHutKtFHItSgSYS8BdkZU003y5MPU+wNepscr0tU2otmH8qL7dCajvyGiJBQz8ZZ8bb8SuY7JYvwqhcWJukaPLAg2Ozxpb7C0PXRSg6TvzN/wXHxvPAX6aF9/dwtnUAqmMzSHidmpFejzAyzpltW0d9l0rVXLNWXmmgh5Y6yC/RDCPO31I5FSD1kcJ3hSIDmDgacB9br5jL6njZ4m0+LTIS+0jF+6Odsbppoo+6iO+/jtQDCXgVB7qP0TuHbtmHZLILFKoBHWdMwWDpckAKyuRoWa6n8DHFU4UT/+yk4L5uYyHMTbVt1peEGDsB5UDwAcuX5YL9yNoL/bzal48DZchiRjDu0S4ZclUXhxk/0M7+Pn2TaC+gB6BKeNU2mYWDSzd3rAVg7Bs4qboBy+LZ/YMSE5xFsPBUgOjAPPdI15isd5/sep8D3TTJ4Edq2X9Xi3U/3CypIllBmy/D1pCxBKpvf4LmxeZ1iuoFpA0jVwfl26f9KfZgd/i9mF0HRI2pDsbhaVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(136003)(39860400002)(366004)(83380400001)(38100700002)(33656002)(5660300002)(8936002)(186003)(2616005)(2906002)(36756003)(316002)(91956017)(66946007)(76116006)(7416002)(66556008)(66446008)(4326008)(8676002)(64756008)(66476007)(110136005)(41300700001)(6506007)(54906003)(86362001)(53546011)(38070700005)(6512007)(26005)(71200400001)(6486002)(478600001)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6qd5Mcvazkpu5NkURJjXj0krVJBFSKUVhPy282rhmZ5NSCENBzD6wFJfS+S5?=
 =?us-ascii?Q?0SU+f1lDDDWI3uFwTnARmKuuKU1kjt+2UArIhWuSPGlqCuFaoTxo8yY/Pw19?=
 =?us-ascii?Q?Ge3yUHxTTpyOIMy4sxjeyyxBhnWsHTrlK6Wgt+YzsrUKbc+Iv9sHoyyo8mBV?=
 =?us-ascii?Q?tGE1EZVSbzxFdHSXv0Mky1cX8j5HXUG0uEVlmBQ10O8satWxHHSF+D+iLvr+?=
 =?us-ascii?Q?yZRX7sLUPyODFbDj24MZ7k78JJaYmOBfF0XHOfGazq3dujYun5zMZb1vB6Ut?=
 =?us-ascii?Q?Dr36SmIeIAPML/uI7hwVCncEZ7sinrXRnK44z7Iy7XUclSCHY0wWxc8ugvbI?=
 =?us-ascii?Q?bdL3HllDRoAd2P3HdIDywNpni+yeN377iUf7iwiaodb6HZeo5FfeisNo8KfP?=
 =?us-ascii?Q?kvyHZegcBSEWLUBXXfndUXgYDSuRhJgW7eFHsZbkQKsXilP0dw4y+pkO/U1k?=
 =?us-ascii?Q?8XBOvwOj8yTQCS2huYlJ34/4h64hUk+ZRc6sab2LNyYaI88XWT6lWv4eOFNL?=
 =?us-ascii?Q?75qpCyWBc09VnuVsyKaBDFyYVMsQiueRhf94TyNUxD3K9a5cN6s3PY7/Qyiv?=
 =?us-ascii?Q?8DwZRhyixP7kiaiAEuuyV4j/titLZbrPM18Lu4XtD3gQOoxtuVcGXw2tEsXR?=
 =?us-ascii?Q?RLdlNTwNBepQKp1PauPDoWgiW08n/CbroMlur8O0KZYdkvS7RY6sy60jWMgw?=
 =?us-ascii?Q?JbuHxEj9TvKbM4MBJVuY+BsLFDf9svOVWL2SecrFF1R8VcVZZUNrF41ZV06z?=
 =?us-ascii?Q?6SI5rbRUSZ8fY6O5OYepElo2mVAXwqrfZiYTpWi4Bd0qxAkPxMoNn9SH50AA?=
 =?us-ascii?Q?+z97m5vk9pdfxepxmx2HcHC9JKu79DWLrdGDRaMeIVQyWuPLhIa5Zb8yTy7J?=
 =?us-ascii?Q?z6FBYQcro8tDPxRhpDScmuBpvsFzdcpupIqtCoY+u5p85QwiS18nmbBFvWX3?=
 =?us-ascii?Q?/X9HPxYx0FqXaKGxp+EMe1zPN1y3ZRAVNSjgt9zk4kvo9YkOeKJlMjLhrzpp?=
 =?us-ascii?Q?0hhSi+OMev+7aybrGZzrap9tQCuXymxuF941aCeDoWZFYeZE6h3QEI8MNWdu?=
 =?us-ascii?Q?HihkYdLXPsCVCJgjf9lmQ4dKMZFdwoJQWqQz9yKXaQekxmRjZtVy9jpOxGei?=
 =?us-ascii?Q?bs+Mx2nkdZfREiF70IcnQeDzSL1PkDko9Qowq5qfeDnZad8PDk7EOuf8Dmw0?=
 =?us-ascii?Q?UnLV3bzbwYVS8juM84hRB7JpiPh1Uq1pig2EIZsUYoho8+ZPvhkTVvatD+O7?=
 =?us-ascii?Q?+b9ANbilNad+PM7VaVVrRZWdjTejeW931IEXGDkO0qQRcBjdk0ew7Ga4nKL0?=
 =?us-ascii?Q?/YDo4abz9ZqS+oy1sx0MfMLadB6AX05rESyRbh5K+d6qDsQbXbcbSKCjRGnl?=
 =?us-ascii?Q?ULCdmYk8QUAIwe9fwgwk0QXyKyZZZX4NwZB8dZruWVlddh1lxUTUEQFGrpVt?=
 =?us-ascii?Q?DZ11LReQZQzqg6ySE64APSF7LSU9ayP0dQt1CjxrOpCwTvE0nGtjW2Whv5zm?=
 =?us-ascii?Q?uzUuXDdP9P+9abvoIhurwxaUtcfbeoyZsFIRrH/p6ZCF8uONxys+JQgmUNNo?=
 =?us-ascii?Q?TTow6HvNCOk35DlxloWabsKkqQpC7pEISF4/UTPYqeJNFxo3JB/HceVEhwf4?=
 =?us-ascii?Q?vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B74C339A860EEC448CBF1DBA16F06BA9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c16f76d-b91d-4a1b-3736-08da91b54ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 16:15:12.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fEYtarKVjFgNSCniNmY91rVdOZDS0vfVjPmUbNqZD6WT7uF8lU2UNSJKZdwA3urFhsOLglTD201SccVhs84xzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_10,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080059
X-Proofpoint-ORIG-GUID: x5f_wc6upijpf1H68PoXLpKc8TDRXWR4
X-Proofpoint-GUID: x5f_wc6upijpf1H68PoXLpKc8TDRXWR4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Sep 8, 2022, at 11:56 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Thu, Sep 08, 2022 at 11:44:33AM -0400, Jeff Layton wrote:
>> On Thu, 2022-09-08 at 11:21 -0400, Theodore Ts'o wrote:
>>> On Thu, Sep 08, 2022 at 10:33:26AM +0200, Jan Kara wrote:
>>>> It boils down to the fact that we don't want to call mark_inode_dirty(=
)
>>>> from IOCB_NOWAIT path because for lots of filesystems that means journ=
al
>>>> operation and there are high chances that may block.
>>>>=20
>>>> Presumably we could treat inode dirtying after i_version change simila=
rly
>>>> to how we handle timestamp updates with lazytime mount option (i.e., n=
ot
>>>> dirty the inode immediately but only with a delay) but then the time w=
indow
>>>> for i_version inconsistencies due to a crash would be much larger.
>>>=20
>>> Perhaps this is a radical suggestion, but there seems to be a lot of
>>> the problems which are due to the concern "what if the file system
>>> crashes" (and so we need to worry about making sure that any
>>> increments to i_version MUST be persisted after it is incremented).
>>>=20
>>> Well, if we assume that unclean shutdowns are rare, then perhaps we
>>> shouldn't be optimizing for that case.  So.... what if a file system
>>> had a counter which got incremented each time its journal is replayed
>>> representing an unclean shutdown.  That shouldn't happen often, but if
>>> it does, there might be any number of i_version updates that may have
>>> gotten lost.  So in that case, the NFS client should invalidate all of
>>> its caches.
>>>=20
>>> If the i_version field was large enough, we could just prefix the
>>> "unclean shutdown counter" with the existing i_version number when it
>>> is sent over the NFS protocol to the client.  But if that field is too
>>> small, and if (as I understand things) NFS just needs to know when
>>> i_version is different, we could just simply hash the "unclean
>>> shtudown counter" with the inode's "i_version counter", and let that
>>> be the version which is sent from the NFS client to the server.
>>>=20
>>> If we could do that, then it doesn't become critical that every single
>>> i_version bump has to be persisted to disk, and we could treat it like
>>> a lazytime update; it's guaranteed to updated when we do an clean
>>> unmount of the file system (and when the file system is frozen), but
>>> on a crash, there is no guaranteee that all i_version bumps will be
>>> persisted, but we do have this "unclean shutdown" counter to deal with
>>> that case.
>>>=20
>>> Would this make life easier for folks?
>>>=20
>>> 						- Ted
>>=20
>> Thanks for chiming in, Ted. That's part of the problem, but we're
>> actually not too worried about that case:
>>=20
>> nfsd mixes the ctime in with i_version, so you'd have to crash+clock
>> jump backward by juuuust enough to allow you to get the i_version and
>> ctime into a state it was before the crash, but with different data.
>> We're assuming that that is difficult to achieve in practice.
>=20
> But a change in the clock could still cause our returned change
> attribute to go backwards (even without a crash).  Not sure how to
> evaluate the risk, but it was enough that Trond hasn't been comfortable
> with nfsd advertising NFS4_CHANGE_TYPE_IS_MONOTONIC.
>=20
> Ted's idea would be sufficient to allow us to turn that flag on, which I
> think allows some client-side optimizations.
>=20
>> The issue with a reboot counter (or similar) is that on an unclean crash
>> the NFS client would end up invalidating every inode in the cache, as
>> all of the i_versions would change. That's probably excessive.
>=20
> But if we use the crash counter on write instead of read, we don't
> invalidate caches unnecessarily.  And I think the monotonicity would
> still be close enough for our purposes?
>=20
>> The bigger issue (at the moment) is atomicity: when we fetch an
>> i_version, the natural inclination is to associate that with the state
>> of the inode at some point in time, so we need this to be updated
>> atomically with certain other attributes of the inode. That's the part
>> I'm trying to sort through at the moment.
>=20
> That may be, but I still suspect the crash counter would help.

Fwiw, I like the crash counter idea too.

--
Chuck Lever



