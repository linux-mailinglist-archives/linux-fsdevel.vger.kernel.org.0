Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8C761D09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 17:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjGYPNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjGYPMw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:12:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2BE122
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 08:12:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7oNFc015603;
        Tue, 25 Jul 2023 15:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9+zCrv4uhypo5zHaijzJZAolU7UBAhH5+A0JcBUelDc=;
 b=J8X8+b/l9bYbosWyfN+udbQk78oIspE75JxbdVtnJeAEMhUU7fYgi4+bDL/9VDKTbkn6
 mEzSw7LrG1vpDFpih/k6OcgRs4k/AfaCscAeQgwY/nfEppyhYXCoxzYQB35gpcbhCyOP
 GzViHJQiua9EecV9LAHvoy6frF0DYCpHBPLZNHrIxETC9dg5uBysDKFTfnwSxQz6Qk0t
 Xfia/FsRfLliyX3r8ZHljI4p5fv0swXOfhwDdIRY9ufZUtroKOnw4wv/EfKan2omzqjw
 TJ8yIS/BCEfgOyTrKLyefcqdr7F1oMC2EYB0GmMVneWdRFNofcPhWrbNefaWlB7LgH6F kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtw9e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 15:12:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PEtehS022905;
        Tue, 25 Jul 2023 15:12:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4wfw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 15:12:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRZRW10Iue7T7nYdo8HwnvKbbOyexlUn+KgLZtGVoOKrruDF82OZUhiZKIl/fJ4ORocQMWXwnsOwfVh3H44iwHPkhwBeoRyfUG+IrJmfsReTTOUsfu89T0uDPSwNfdiACzaiBKH6yf0ZRYCKtpehShIeW8rZ+3aqg5MMQXqjiOZomxRJ78WOXGeOFSolz4PVd262oKJMimkWtJldeKu7sd6A8rXE1GXrCfJ033Y1H6Vu9ZBIZX1f6LB0O6UAMJyJX9yc9Ysjgk+lWNxd6pMeMC9X1thXwmtUL7Le3BP/8p3iRtMNqcwYUXC7Li9e04NGSZ3TV4GqL7yBvbbgJzhc2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+zCrv4uhypo5zHaijzJZAolU7UBAhH5+A0JcBUelDc=;
 b=Bur4HKW1MZzbSOqsiqKhl1zGZVvWFYrrTtvVeqLaVmgmhn1bhZkIzJtaDlSLMdIIKOzEBmPZjSekm9HJ8QU74bejGc2WFCoJgFritmDE/of9UukBJtomDVDmL/D9lgAWADnDAdykcBt6YjhShTlwDOKKhaZMj5qLtOLf7wfrxQTs+Lbgvgn6lpt5KlN3dJBgYZuxqtUbiahCMCNMlqtYSwqA7myfXUocUO6UuOnOwbQBiEmURvLltA51bbXeH9ookdX6h6LavONEIq5tNSctefoBOFvLoX/WmOMmtly+uloxBE9j/mamg0xxMk0CIc3G5rNt8bfADDfux3vfYr0pQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+zCrv4uhypo5zHaijzJZAolU7UBAhH5+A0JcBUelDc=;
 b=PLnGhe9/sz+364nXfcx3fbaNDu5WJKREIk/HVgBZh9XRSienwk58AiP8spSqqa7+EOsclb7o1COYs+ZVmtiCSx7oztOuZo7lh46Q6+2RrD2zCNkXjjUa39NVOZAYMKdsNnzjzMb1ZDbloSLOKD96Eg9DWwMlzxchkxv2hFw0710=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7630.namprd10.prod.outlook.com (2603:10b6:610:178::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Tue, 25 Jul
 2023 15:12:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:12:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Chuck Lever <cel@kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] shmem: stable directory offsets
Thread-Topic: [PATCH v7 3/3] shmem: stable directory offsets
Thread-Index: AQHZq3ssrh2qup7PxEOYTribWI6Yka+9nbyAgAjC0oCABF1CAA==
Date:   Tue, 25 Jul 2023 15:12:22 +0000
Message-ID: <53E23038-3904-400F-97E1-0BAFAD510D2D@oracle.com>
References: <202307171436.29248fcf-oliver.sang@intel.com>
 <3B736492-9332-40C9-A916-DA6EE1A425B9@oracle.com>
In-Reply-To: <3B736492-9332-40C9-A916-DA6EE1A425B9@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7630:EE_
x-ms-office365-filtering-correlation-id: 3176c027-3fe0-44bb-9947-08db8d218c12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pTtkrQTm/QxbVIdo1EtvvKJuZmJksbg/wK2zyIMQrzShpfGo0rIF9C05BECtYJRaMEgO+F+vdXCP3eDViwb6aKXhb6F0Vlbok7/Cdl1UhGTSp/7M8/7xC/fvEHh9G1DH0rja3QU49qNsrGbXcq51ulxYcNyi6UarAoYUCLp72U3vc/ZAvzjkRTmsXCFerD4yD2MI0FTrgloZ5YAxiCMvw/mrS4G37pTaqDcd6h045Q5yizAMc6/h03SeOTWHtvfkP29OE4a1WA1+rA1dmUr8sxR9keytQGT1wzM04MjmjU8PeBDMgr4bqOpwLf6OxGVfg4yiWekI0rMn1zRsOePq4kQ7XzLvvLT/Sttaulz3r//K1h8A5wnjHxDHq8Jz7lckD2VREYZm+/bQUVvifrbvsT5ClFkYf5++wKSRbHx1ZKxAtuN/1niGutyO1aF+SX413Y+9FbmuSmmkhoTO0F6R3J/THm4tkt7q3IRiU9WttK/ODFKOOBTuuue+7M4tltMXHBU/3BhrWeGOmIYyWMa8t6dhuNkz2qeEIoBFI/CZ9dRgWZ1W5oq/yXYR0Bzz1Aq36KMQGV/WgTC897Uamur/0dLSB/AQ1WUAAaVie1S5/BDjikh86ZZf8BbOpziNT+UC4/xgtCHpSsbcKJg3AdrwXcqSsOuJ5WJ4xEOA+ZK9o+0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(5660300002)(8936002)(41300700001)(2616005)(26005)(7416002)(66899021)(53546011)(6506007)(8676002)(186003)(83380400001)(91956017)(122000001)(71200400001)(66446008)(64756008)(4326008)(66556008)(76116006)(316002)(66476007)(66946007)(6916009)(38100700002)(33656002)(19627235002)(86362001)(966005)(6512007)(6486002)(36756003)(2906002)(478600001)(30864003)(54906003)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KXAIOEhFeQnmUpGg6xUHKTbZK5e1mgQV97shOoSJQxRvOSB8B8Xa07ePc+sb?=
 =?us-ascii?Q?sHSkvHofdAhbNUUgOGU/lLSlEb1CX2u0Pbo/mGDzyDql6PiqHcdUT8xhIA8p?=
 =?us-ascii?Q?DH8V3mt9qrpBcrP9WOKnSfRJseEH+bjt/2y5UmAQrbZSSp5S7VxTfQLhFaUC?=
 =?us-ascii?Q?X99wkiE89mm/EHgUIo/UMIO//OFnSvqvZa5xhcoh1hL3MN2nGSy1rernpuCi?=
 =?us-ascii?Q?zppP/lzNoW+Gw5iLY60fBojSJtUI50wvenWo/Iui4x876KJV5+p1Sht8ovg0?=
 =?us-ascii?Q?dKUpA9EL/+TdFEf/9hmE9gLb1Sx+bdmcCfq87o4PgLwckh4zDlWR0QdGmQTL?=
 =?us-ascii?Q?leQpUMcITpm6DEOWsqq3FLILC6BA85jwpOC6jvdzWNMXK+4xA/GLSJKFYdNV?=
 =?us-ascii?Q?tHF30JVfMT/XX/WFPT4ng4Nco6ADA/CQtZC05eAj+QA6t93DEtF3ScjPnMx/?=
 =?us-ascii?Q?7jNyDrqgy89AhOADQrEkD+CGFZXGzLfjWrNFb4Iu6RdRwBCWkgyuEk1h93zS?=
 =?us-ascii?Q?X3m4cxb6qQbxWajagpTbOnEIZKEma7CusqUNS0He5wlgBpIt9HBdKil692fJ?=
 =?us-ascii?Q?Z2inn3c0Dkp9gt0uL4QnIvWxxnAAZnVZlGnMBeytQsd0cZCOCS71cFRGHilm?=
 =?us-ascii?Q?zthXQagYVjXpqU4AFkvaPji0W7yJI04/RrqGFfZEHA91ZpWYx7BRDN7tbYdG?=
 =?us-ascii?Q?s6ZrdjNr8kek2xckD12hS2Rt4o0zyPB4dTXi/DAzb1C55YwXogQCPANlKtrI?=
 =?us-ascii?Q?OHpVq/eEQFueTg7ALDHax4Efg1FM+r3VjmszIGigPyNAQ2LuQ6NZgRBjQShB?=
 =?us-ascii?Q?LCpoWonTOzmoHOemu5Ss9ns7Na1jDXjkkedMMG4RYj3X5T7UtPr3AykZbij9?=
 =?us-ascii?Q?6E5nhWX3lW1fAs+61/LEZUXSBYq/Kk8p0bur1/YKrPGE2NC2HoFXboTwEyQo?=
 =?us-ascii?Q?bMnZm0yWH7ke9/GNuCq0vKEywRP6a4JcVVs7qrQ9TaqQ1hPfoRZwSfWxv2L5?=
 =?us-ascii?Q?rkZACQP05iRz6NLoON5H8JF/ruOO0Lg4fY8D6ygLMlMtqg32VVIJ77giIJoU?=
 =?us-ascii?Q?ZuqvXMxLvizxOXE+Wp6Yya1xSGo10kd39sdegjEKgE8/nM3TlT8bAWQ7OaZM?=
 =?us-ascii?Q?Pl8JCZ/hNlGvBY8a7e8qesjJRNLgEe4bQgewe4SUmd4OsYWQEDGBg4v2+F1k?=
 =?us-ascii?Q?lRiNpgHMTuq9actm5JTkni9BUJXVxlPYXI6XQs0VKsLG/vAilvszXahwlIQR?=
 =?us-ascii?Q?OacvCsB2FlDx3WhZd+fCvvT309COEwYZMa8jmEbJwQnMpMOJ2wYaUtqiuOva?=
 =?us-ascii?Q?666ed0ggQoRRh/bygB3oWOlBR5pf5Gz8JZMaTfi7xNoI8N1+O2qetWcxKc5t?=
 =?us-ascii?Q?DbM/UwXSg8JHgMAZpsJif+tliubUtOAm6qBbsA3x15F0qYlsdyIruDEDv/V1?=
 =?us-ascii?Q?dwFRZQ9VvOfawL/gg6VlTSlxg4xSuzp7ilW1wgQTQ5Vz71siE/pGS3yHdSij?=
 =?us-ascii?Q?HotmCXyB7jVyJsxeTl/UGp1l8R3H8rZjXRM9KPU0Fls6K3Yc3SpMqUUHLhbD?=
 =?us-ascii?Q?fyxjv0vmrkB8SAdyYxkE48TwNZUv3nc62mXTdBvePSy7IdYIpS0DQRCN0dC0?=
 =?us-ascii?Q?vQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47C4090AFF42934CBB4A396DB7385C42@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vL6F+bMEJnQxgc3w32clGyP7KPDcltVl2yLKEEQBkNSOY0rLlKFW9at3+7Wy?=
 =?us-ascii?Q?0XZnjwVjmslucgMdQExYZXlnkLqAbcNDdZ3sE44qhv1kDRluxV8YtMjXfgED?=
 =?us-ascii?Q?nw0sZ1ThI+Eaa6ppAuj88W8cEz7jbtKxdhQ0uX5PnKwscECC0S+dg0Klu+sD?=
 =?us-ascii?Q?rFncc3LG7TQNsswtOvXaANP0Hy2yyn7Pl/NEk6/fF8bp97veELvPS5X/vOaP?=
 =?us-ascii?Q?CgfIlSgWqyxhgenhjhzRaMHmhZgPtitFwybpQAo0kqYiavzY5A+bQG9hGxYG?=
 =?us-ascii?Q?SHiKxp/v4lx/AsG60zT73qYekOCnbONK06RmmOi0sKQXO7Skx/EgPUxba238?=
 =?us-ascii?Q?8gfth8ODQRh3w9T4w0jmPhriPEp9BcT5vzT0eSK6iy3fzwlKUKhGscmiCfAT?=
 =?us-ascii?Q?JAp+dufyLdbosMP9LTGiwpSyVFFQxCisg/wW80oMZrKxq5rKA5acjOdG82nX?=
 =?us-ascii?Q?CJjnPoGI5k4uQo/AVFI9Y4MQ9lHuzw/HQKGYRVcBE+qrVvAVbgVYAE6NFRmw?=
 =?us-ascii?Q?Eijxjcl83kf12ct6Ba56h1tf32B//GZfQEtaJ/j8ZmEpGq8ouyOM//90+sr6?=
 =?us-ascii?Q?z4RuKlM0aanPbv4PUr1Aflc5CYAaRlqZE6iRnqj1PS4IozK6vYwk5UxnujPy?=
 =?us-ascii?Q?1xzSOz4WoqPMKD8Pwavs4YdODHu5swLLHkywMlrIWjtcwug8BxVzDS6uGmNl?=
 =?us-ascii?Q?indlZVDU7g4Js13frXwizMDQDZUagLx7wgosHlR1bhtlJORxH5ExK7SqHZAb?=
 =?us-ascii?Q?zppVG/g3UPrOGHH+W2bBMM2FeKAKehbb5Jpc9Kh94OsNBKopdtzKx/P21xIR?=
 =?us-ascii?Q?6BjpUhqYo5sn+TSAKdfCgy/GnZzwf5tZ+lQxv4O+Mbdut0tA0pUUTP/YlbGL?=
 =?us-ascii?Q?zbApR45AOHifKosdGbqM896k3WaHMPk8OH3XAr5uE6J9sAp+nhqAcFEMCU6P?=
 =?us-ascii?Q?CD0DW1bkkKSz2jHz6NWt95YauD1bqQAwgc1Hlg/IJUjRgIQYTb3szWEtW9M4?=
 =?us-ascii?Q?llr+4kVM+fFD9qoIEuhJUz1stNXgrjelqYaKrsh86UcOT00=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3176c027-3fe0-44bb-9947-08db8d218c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 15:12:22.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MtIt47nRISoKJT+1Qf04spYmS1RC19+mXZ8W728M/GClrSTUQFtApxOCKDTE6NNejErCdIb01uekeV4r43sKYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250134
X-Proofpoint-ORIG-GUID: pUVqseuX_RcM4eloeifhSqJUZV_zGARr
X-Proofpoint-GUID: pUVqseuX_RcM4eloeifhSqJUZV_zGARr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jul 22, 2023, at 4:33 PM, Chuck Lever III <chuck.lever@oracle.com> wro=
te:
>=20
>=20
>=20
>> On Jul 17, 2023, at 2:46 AM, kernel test robot <oliver.sang@intel.com> w=
rote:
>>=20
>>=20
>> hi, Chuck Lever,
>>=20
>> we reported a 3.0% improvement of stress-ng.handle.ops_per_sec for this =
commit
>> on
>> https://lore.kernel.org/oe-lkp/202307132153.a52cdb2d-oliver.sang@intel.c=
om/
>>=20
>> but now we noticed a regression, detail as below, FYI
>>=20
>> Hello,
>>=20
>> kernel test robot noticed a -15.5% regression of will-it-scale.per_threa=
d_ops on:
>>=20
>>=20
>> commit: a1a690e009744e4526526b2f838beec5ef9233cc ("[PATCH v7 3/3] shmem:=
 stable directory offsets")
>> url: https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/libfs-Ad=
d-directory-operations-for-stable-offsets/20230701-014925
>> base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everyt=
hing
>> patch link: https://lore.kernel.org/all/168814734331.530310.391119055106=
0453102.stgit@manet.1015granger.net/
>> patch subject: [PATCH v7 3/3] shmem: stable directory offsets
>>=20
>> testcase: will-it-scale
>> test machine: 104 threads 2 sockets (Skylake) with 192G memory
>> parameters:
>>=20
>> nr_task: 16
>> mode: thread
>> test: unlink2
>> cpufreq_governor: performance
>>=20
>>=20
>> In addition to that, the commit also has significant impact on the follo=
wing tests:
>>=20
>> +------------------+----------------------------------------------------=
---------------------------------------------+
>> | testcase: change | will-it-scale: will-it-scale.per_thread_ops -40.0% =
regression                                   |
>> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE C=
PU @ 3.00GHz (Cascade Lake) with 128G memory |
>> | test parameters  | cpufreq_governor=3Dperformance                     =
                                               |
>> |                  | mode=3Dthread                                      =
                                               |
>> |                  | nr_task=3D16                                       =
                                               |
>> |                  | test=3Dunlink2                                     =
                                               |
>> +------------------+----------------------------------------------------=
---------------------------------------------+
>> | testcase: change | stress-ng: stress-ng.handle.ops_per_sec 3.0% improv=
ement                                        |
>> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CP=
U @ 3.00GHz (Skylake) with 32G memory        |
>> | test parameters  | class=3Dfilesystem                                 =
                                               |
>> |                  | cpufreq_governor=3Dperformance                     =
                                               |
>> |                  | disk=3D1SSD                                        =
                                               |
>> |                  | fs=3Dext4                                          =
                                               |
>> |                  | nr_threads=3D10%                                   =
                                               |
>> |                  | test=3Dhandle                                      =
                                               |
>> |                  | testtime=3D60s                                     =
                                               |
>> +------------------+----------------------------------------------------=
---------------------------------------------+
>>=20
>>=20
>> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202307171436.29248fcf-oliver.sa=
ng@intel.com
>>=20
>>=20
>> Details are as below:
>> ------------------------------------------------------------------------=
-------------------------->
>>=20
>>=20
>> To reproduce:
>>=20
>>       git clone https://github.com/intel/lkp-tests.git
>>       cd lkp-tests
>>       sudo bin/lkp install job.yaml           # job file is attached in =
this email

Has anyone from the lkp or ltp teams had a chance to look at this?
I'm stuck without this reproducer.


> I'm trying to reproduce the regression here, but the reproducer fails
> at this step with:
>=20
> =3D=3D> Installing package will-it-scale with /export/xfs/lkp-tests/sbin/=
pacman-LKP -U...
> warning: source_date_epoch_from_changelog set but %changelog is missing
> Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.Py4eQi
> + umask 022
> + cd /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILD
> + '[' /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROO=
T/will-it-scale-LKP-1-1.x86_64 '!=3D' / ']'
> + rm -rf /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILD=
ROOT/will-it-scale-LKP-1-1.x86_64
> ++ dirname /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUI=
LDROOT/will-it-scale-LKP-1-1.x86_64
> + mkdir -p /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUI=
LDROOT
> + mkdir /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDR=
OOT/will-it-scale-LKP-1-1.x86_64
> + CFLAGS=3D'-march=3Dx86-64 -mtune=3Dgeneric -O2 -pipe -fstack-protector-=
strong --param=3Dssp-buffer-size=3D4'
> + export CFLAGS
> + CXXFLAGS=3D'-march=3Dx86-64 -mtune=3Dgeneric -O2 -pipe -fstack-protecto=
r-strong --param=3Dssp-buffer-size=3D4'
> + export CXXFLAGS
> + FFLAGS=3D'-O2 -flto=3Dauto -ffat-lto-objects -fexceptions -g -grecord-g=
cc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2=
 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1=
 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1  =
-m64  -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protectio=
n -fcf-protection -I/usr/lib64/gfortran/modules'
> + export FFLAGS
> + FCFLAGS=3D'-O2 -flto=3Dauto -ffat-lto-objects -fexceptions -g -grecord-=
gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D=
2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc=
1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 =
 -m64  -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protecti=
on -fcf-protection -I/usr/lib64/gfortran/modules'
> + export FCFLAGS
> + LDFLAGS=3D-Wl,-O1,--sort-common,--as-needed,-z,relro
> + export LDFLAGS
> + LT_SYS_LIBRARY_PATH=3D/usr/lib64:
> + export LT_SYS_LIBRARY_PATH
> + CC=3Dgcc
> + export CC
> + CXX=3Dg++
> + export CXX
> + cp -a /export/xfs/lkp-tests/programs/will-it-scale/pkg/will-it-scale-lk=
p/lkp /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/=
will-it-scale-LKP-1-1.x86_64
> + /usr/lib/rpm/check-buildroot
> + /usr/lib/rpm/redhat/brp-ldconfig
> + /usr/lib/rpm/brp-compress
> + /usr/lib/rpm/brp-strip /usr/bin/strip
> + /usr/lib/rpm/brp-strip-comment-note /usr/bin/strip /usr/bin/objdump
> /usr/bin/objdump: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_b=
uild/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/wr=
iteseek2/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROO=
T/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/dup1_threads': =
No such file
> /usr/bin/strip: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_bui=
ld/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/writ=
eseek2/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build/BUILDROOT/=
will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/will-it-scale/dup1_threads': No=
 such file
> /usr/bin/objdump: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_b=
uild/BUILDROOT/will-it-scale-LKP-1-1.x8/export/xfs/lkp-tests/programs/will-=
it-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmark=
s/will-it-scale/brk1_processes': No such file
> /usr/bin/strip: '/export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_bui=
ld/BUILDROOT/will-it-scale-LKP-1-1.x8/export/xfs/lkp-tests/programs/will-it=
-scale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64/lkp/benchmarks/=
will-it-scale/brk1_processes': No such file
> /usr/bin/objdump: '/export/xfs/lkp-tests/programs/will-it-sc_processes': =
No such file
> /usr/bin/strip: '/export/xfs/lkp-tests/programs/will-it-sc_processes': No=
 such file
> /usr/bin/objdump: '6_64/lkp/benchmarks/will-it-scale/pread2_threads': No =
such file
> /usr/bin/strip: '6_64/lkp/benchmarks/will-it-scale/pread2_threads': No su=
ch file
> /usr/bin/objdump: 'ale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_=
64/lkp/benchmarks/will-it-scale/poll2_processes': No such file
> /usr/bin/strip: 'ale/pkg/rpm_build/BUILDROOT/will-it-scale-LKP-1-1.x86_64=
/lkp/benchmarks/will-it-scale/poll2_processes': No such file
> + /usr/lib/rpm/redhat/brp-strip-lto /usr/bin/strip
> + /usr/lib/rpm/brp-strip-static-archive /usr/bin/strip
> + /usr/lib/rpm/check-rpaths
> + /usr/lib/rpm/redhat/brp-mangle-shebangs
> mangling shebang in /lkp/benchmarks/python3/bin/python3.8-config from /bi=
n/sh to #!/usr/bin/sh
> *** ERROR: ambiguous python shebang in /lkp/benchmarks/python3/lib/python=
3.8/encodings/rot_13.py: #!/usr/bin/env python. Change it to python3 (or py=
thon2) explicitly.
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/lib2to3/pgen2/t=
oken.py from /usr/bin/env python3 to #!/usr/bin/python3
> *** ERROR: ambiguous python shebang in /lkp/benchmarks/python3/lib/python=
3.8/lib2to3/tests/data/different_encoding.py: #!/usr/bin/env python. Change=
 it to python3 (or python2) explicitly.
> *** ERROR: ambiguous python shebang in /lkp/benchmarks/python3/lib/python=
3.8/lib2to3/tests/data/false_encoding.py: #!/usr/bin/env python. Change it =
to python3 (or python2) explicitly.
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/lib2to3/tests/p=
ytree_idempotency.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/config-3.8-x86_=
64-linux-gnu/makesetup from /bin/sh to #!/usr/bin/sh
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/config-3.8-x86_=
64-linux-gnu/install-sh from /bin/sh to #!/usr/bin/sh
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/ctypes/macholib=
/fetch_macholib from /bin/sh to #!/usr/bin/sh
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/byte=
design.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/cloc=
k.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/fore=
st.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/frac=
talcurves.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/lind=
enmayer.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/mini=
mal_hanoi.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/pain=
t.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/peac=
e.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/penr=
ose.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/plan=
et_and_moon.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/tree=
.py from /usr/bin/env python3 to #!/usr/bin/python3
> *** WARNING: ./lkp/benchmarks/python3/lib/python3.8/turtledemo/two_canvas=
es.py is executable but has no shebang, removing executable bit
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/turtledemo/yiny=
ang.py from /usr/bin/env python3 to #!/usr/bin/python3
> *** WARNING: ./lkp/benchmarks/python3/lib/python3.8/idlelib/idle.bat is e=
xecutable but has no shebang, removing executable bit
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/idlelib/pyshell=
.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/ziptestdat=
a/exe_with_z64 from /bin/bash to #!/usr/bin/bash
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/ziptestdat=
a/exe_with_zip from /bin/bash to #!/usr/bin/bash
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/ziptestdat=
a/header.sh from /bin/bash to #!/usr/bin/bash
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/bisect_cmd=
.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/curses_tes=
ts.py from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/regrtest.p=
y from /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/test/re_tests.p=
y from /usr/bin/env python3 to #!/usr/bin/python3
> *** WARNING: ./lkp/benchmarks/python3/lib/python3.8/test/test_dataclasses=
.py is executable but has no shebang, removing executable bit
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/base64.py from =
/usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/cProfile.py fro=
m /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/pdb.py from /us=
r/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/platform.py fro=
m /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/profile.py from=
 /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/quopri.py from =
/usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/smtpd.py from /=
usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/smtplib.py from=
 /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/tabnanny.py fro=
m /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/tarfile.py from=
 /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/timeit.py from =
/usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/trace.py from /=
usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/uu.py from /usr=
/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/python3/lib/python3.8/webbrowser.py f=
rom /usr/bin/env python3 to #!/usr/bin/python3
> mangling shebang in /lkp/benchmarks/will-it-scale/runalltests from /bin/s=
h to #!/usr/bin/sh
> error: Bad exit status from /var/tmp/rpm-tmp.Py4eQi (%install)
>=20
> RPM build warnings:
>    source_date_epoch_from_changelog set but %changelog is missing
>=20
> RPM build errors:
>    Bad exit status from /var/tmp/rpm-tmp.Py4eQi (%install)
> error: open of /export/xfs/lkp-tests/programs/will-it-scale/pkg/rpm_build=
/RPMS/will-it-scale-LKP.rpm failed: No such file or directory
> =3D=3D> WARNING: Failed to install built package(s).
> [cel@manet lkp-tests]$
>=20
> I'm on Fedora 38 x86_64.
>=20
>=20
> --
> Chuck Lever


--
Chuck Lever


