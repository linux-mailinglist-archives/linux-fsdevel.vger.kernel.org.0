Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EED27B5119
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236626AbjJBLXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJBLXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:23:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C3793;
        Mon,  2 Oct 2023 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696245816; x=1727781816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n4I9O947yaS3rDmw9qIlbc6H98LkzcY6EtglGKQTZ3s=;
  b=d0CjyTlZT6zOoDdNZCtpyXgfScwTl3LK65HdZYLmkyDeL7PPXFqYLHWV
   3N4fGayJoz0dnse9pztEQ8QKoqTPNyYhLbmxrKvb4YN56YvZ/JmYQlG1k
   gkuVnsVesfKZy3AHIELzce1zsYquxXFd5P2xjeh4mpqlfTFLmArQCYrkV
   TxagPY8A0n9WZ1zLUCHgSBzAn38a9FUEehMnMNy9/OGLXLZ78rGRyjqKu
   8H3rceSVCgyt2yZijfVdtEq/gn9YG/X6wVop/hgKVp/5AiH71xwPTjvMI
   WIB2BMvkDEVxSVMLeb5T2eYbDcvnIuopi8KQKbrZQqwskvwRb5UKdn7pu
   A==;
X-CSE-ConnectionGUID: cVRGLBAcR72FsefOJ2T8XQ==
X-CSE-MsgGUID: T4A/vkzlQHu4/c2mjwh9vQ==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="245442914"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 19:23:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+iWVfjjRlEddhsjBl6t0Ap1rS1Uksj4dHjLlltNBpKGxF/RjAm+aAF0PMXBJsvgYhcRFK/WnX9QsSn+0MPF6qO2iiuuuAreqVVSwX1+2TMDNWm2If0mYDq+I1v8Twpk6RkA3LLfT3/FQnGgI95REuT0yXhc8377u5RzwfCoMYGPyfSMssyWaKoFEZSAroHMcuEScqwDJhk+mIc1pw7BGwz+s4+S0mQPsqS6phdix8RC6g4ZB5kUjt4ZwD4wjcBTE0pIdh4O4EWeuBUpmSXhtsslgXKmLB+hV9tFd0VQ6+xQSA6+IuBuN2EVYnCDMAGjONZeRvsyh0IYCERaAbyXxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4I9O947yaS3rDmw9qIlbc6H98LkzcY6EtglGKQTZ3s=;
 b=evXzu1cOJb1fQ0hIpeV1jOJmV9kTBBW+dijCv0N7p0IK4QB8rNblHZZmkagT1Z5SCq5V+8oyt7/PZVRYtEk3UM4YKotHrvkxN0H7y0k15y19sB3Bz3thq3J4GxKahNwSmXsQhnZWGe/subRMPpMqNdSwXWEQM8OmBkJSEJREf/cASy5LuZ/svNMlBIWLPrnHHfmMiALzFFiy7NoxT5GJK09XuVhGTt5FQ8LQGIg168t13ohkx3Y6JJ4qr2F2vL6HAZvz9AsJkBImffv9Tv0QzWw39dYZ3jQmI6iCjb07WphSgPmzrPhOdZXrbEweNgovzfXTKm3o8FDk9Hm61bmNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4I9O947yaS3rDmw9qIlbc6H98LkzcY6EtglGKQTZ3s=;
 b=W5CEU9tNphz0bVMsZr4K699cMc9iy3ikX1GZSNL5+643Y3wFxFi7k75s5R+PlsASCsJ9Hq5OWtbDfaTeLI/rVNX3769YvaZzL62lS6KLIbhH1Au4IPz7i+c2eJVoW1bSMJHU1TQHSe4fFMEDbl27F1c+QV4djrBOQlhl5w5xFp0=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6853.namprd04.prod.outlook.com (2603:10b6:610:9f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.19; Mon, 2 Oct 2023 11:23:32 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 11:23:32 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: RE: [PATCH 04/13] block: Restore write hint support
Thread-Topic: [PATCH 04/13] block: Restore write hint support
Thread-Index: AQHZ6/bmbhsr5VwL90evUuEgotR0H7A2bAJQ
Date:   Mon, 2 Oct 2023 11:23:32 +0000
Message-ID: <DM6PR04MB65759F0790E391DC7D5D8139FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-5-bvanassche@acm.org>
In-Reply-To: <20230920191442.3701673-5-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6853:EE_
x-ms-office365-filtering-correlation-id: d9fde175-6e09-4460-2c01-08dbc33a02d6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tK4H4IQsDzv2tfiebkWQNFokT8er8xJn1acBWPhxKWQcqbKUkx/01mTtMMaUV0RR8V+YIZF+zzMuRoF9ZF7jbsJH/NSO62FnVrbhZk08gd0bqKT619SjbM7dElNVHRHtzaDSLNxEOtj3iqhqRBJiY0TCWqlvabX421/ejOEhDXjJtT2ARyQhjfICccsq0z4IkdDFFyIU3/UB6BlLwWpNnGlSLr+GQqOFTi8DDgK2VS9UW4OSTzBB6m4ufkxTJMj/skFb8ZeNN1xmaj2bIG5YpetyExXSgTaQ9jUMtvjS396GG7PikJ/dbhxVygzXNONxQHVOSVGEosaDuINN/gPbhXLnf5oA7hvIXlirjnd+3W8UiHQca8UmF2vFu5VA+rJI1Yps4XynsuUzbjV8Q9x8qUCNLSEIK70e8Wj+SJeFIYuqAc56nSLkU1ACPKTRx2/1EBuT/GkgHGJhLYvSLPQhLlwgqtAxE5DZBFOWN5vSEbnMqq1wSB2nYtOFTEJypIaZPSkxMVY2Mm8Ucq657wrN6SxwIJ+BHciiuepXkmGAR6qxgMt3ICUNfzc50JI1d3BbMdzKEPbSWkl9YTFkMOpzE/ld2+4OULYKmROsN0FA30U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66446008)(110136005)(64756008)(86362001)(66476007)(66556008)(54906003)(66946007)(76116006)(38070700005)(55016003)(38100700002)(71200400001)(966005)(478600001)(52536014)(5660300002)(2906002)(316002)(41300700001)(4326008)(7416002)(8676002)(8936002)(26005)(7696005)(83380400001)(122000001)(33656002)(9686003)(82960400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R6r/patoiuxRPRU8eGixk73gPZ3j9D0Me8z/UZhrjFSIo+vjql7+XWbe9x3X?=
 =?us-ascii?Q?guMClSSNB5jDZeLWFlR+CbEdp6wbZm+OzqaCYINnswYCD/Oy1dQ/D4LDo0f9?=
 =?us-ascii?Q?eEgiJ1f8CW1OX0cu3pDR92BVpEuqrnhKQADXeXpYXOVhi5jFqH4oQ9ln5ik7?=
 =?us-ascii?Q?TDR2jUXbe6fC1hiObsHF57cjNPZcjOlQcaYE5TIaqGr4nh3+LQcLb+3DYJQt?=
 =?us-ascii?Q?reWE3zTykLz/2u0l6PzCsPfe8dcwqac+jvs5IieYn5YKQZAl9zEItyRdi7q+?=
 =?us-ascii?Q?kUGILnHXL+jJuHgj8LIl+SUMAeK/wEAxFvs80jGd8r12IsEjSRQnqXPhfcPV?=
 =?us-ascii?Q?NxQT4I3Z7MY4Q3rGdHIsysuZu1qMXf+Npf0UyfLJRa5dHFnG33NQE9mCnp7b?=
 =?us-ascii?Q?aNkRoorEjiyY16MJkUbWJEk7URaLKz4VY6lTnfvdOsEmtx0Ryq8IORQAhr68?=
 =?us-ascii?Q?+utuJ4y/gbfV0wdoCeArR9SkCaY374x+QwFS5RAgs4jYsj1bPd3AY2C8wsE1?=
 =?us-ascii?Q?c50yb5T/bjPlcI9eyHrW4ttscT6nC/myxUuOy8NnxP8QPCRzHsdXIbon14Ei?=
 =?us-ascii?Q?NrPuVP4xX2xCY22GqP9LjopJisBoA01NOWbYHRCYLN8wnQCS9YeCpFX1XX9Z?=
 =?us-ascii?Q?BAdqdu2ayudZmQ4oGOFzPpXO7IQqPJCrhxQ6HJqiYyUaPgkNdhxHzU8a4JiB?=
 =?us-ascii?Q?rM0CJTthZYo2Q2HiW5E3Xy6hoOquBCcaCFnha9NX+IIVmmHJTNEG809ffWK5?=
 =?us-ascii?Q?kRiCcrJTN6s4/M8XnZc+zJ6sS63cNRBHH4+PMzrYq5wBaHvopMLCWD0Y+SGL?=
 =?us-ascii?Q?MTfabeFl77m77CSVTeL5R7s2jUaHTA9Ep1h7jePHIvjygbXApX8msX54Qs4+?=
 =?us-ascii?Q?qlyi2y7kZ/xzNMioHS04PQSvLTdUr+MayIULWDp/C7ElT/oM2wP+5oE9IDUt?=
 =?us-ascii?Q?2r0cB5qjfOAmsFhxKfsSWW9whriIJDLx8RAz9CEaQ+keWOzTEnaT0+pGwbP3?=
 =?us-ascii?Q?i0Q1YloMDrN1luE21rhxHvowmYT/FCV2PlrhXZSXTlZCWy/kjp73ZjBQHgA0?=
 =?us-ascii?Q?vqT7xC8ybmg8weNlmPP1aG/v3jphH2h0CwxwA35W6+UkNHz12mkJV5yyz4WH?=
 =?us-ascii?Q?CzGtfVYM8YRnpkTBDwcznXa6r84c/6ISfFrSLcO8KEJa0iyyWT/EbByxa1yZ?=
 =?us-ascii?Q?1mKbp8r4YmMjvj6WNwxwYb6yZ4/WpqAczgAxD2ZM5tSp5VbClL3+54mi40n2?=
 =?us-ascii?Q?QvWoNlDu2LC9AiSHnlZVwe6Xcs9lkRQGB1XskKKnWssAt+IRSn2LeqlGYPFU?=
 =?us-ascii?Q?vzZJC5BpGxX/jmup3hZVjB8z86UdW+dbwn5JU+Ze5eQNyRuWMKtF5XEjv7Kw?=
 =?us-ascii?Q?jIn9gVoL8dxMwXOixPCsb/MjloMSUBI+l8AH7uZmy0tneTRy1Rt9kbFcZWj/?=
 =?us-ascii?Q?fgDl/Gi9YeCx/0AlG9DuDoxTdU0KFbMmg9RdQPJzMr+QlkOhtiMCdTzdrQfY?=
 =?us-ascii?Q?wtr5GGysGv7QEFbTtaoC/+T1U68LzT0/WrenDrctK40SR0aosCfCGVSSLtTC?=
 =?us-ascii?Q?OgCIx074kN0gxjC4h/STcgigbweFvHaYaJs5Zsqc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UpnpJfc2NWhi8cQCgWkTfV2gpPBqkL7hNFYIsRdPZlatL+rvB8wmWy6HNesY?=
 =?us-ascii?Q?uMFNPzGBCD8krd60gp262Zx9HOXsAxO3kDjILOA8LQDOUgo91k0jIKKV8qja?=
 =?us-ascii?Q?7SpgQ3bg5C21DP1gRWAzivITZcyXtXf7xgwyMMX58BAUHGS5qSck41GjO52S?=
 =?us-ascii?Q?7YvcroH2CfhCjd8XJ+B80+5903hsRNQrVzh8Eq2QIh9pqTAlopbD7JVNWC4b?=
 =?us-ascii?Q?ZdWqK3WKm9sqolR1g2J1U5JDrG7stw8Qq+vnVXhDCNajW3cdMeA9lh6qR+Yc?=
 =?us-ascii?Q?8mkKKCknGTyUg2NSZooC1ftVnVqMzwL8OI2mumgif5qY1UhULqKatW5StDlL?=
 =?us-ascii?Q?YivBmP3ly1bbX7nCn9L5XFYKfHNwKWzxqbuJF6PwVVdLBU0fXynLDj5syvL0?=
 =?us-ascii?Q?Fglld3YIIbK2se2mrfhqpwXaWmpDbZZKa74SKP85+zidxPI9Nz0nBdFcihVZ?=
 =?us-ascii?Q?/EtncWjJX2v/XOk4U1om8kR0OJPVRQ0Q/OaBpP4/04ObjFvLSQzAcm1VhPjA?=
 =?us-ascii?Q?2g7V+s5bHV4t2SSLzU++Je5EMw4GGKzHVdmMbvVwZ2zD0wcjnsZcD1bSb2Gk?=
 =?us-ascii?Q?ON7h+iBLdiDa0rsBhEO/GLO62Ed82Md+402AXWlsQxTtqc5lJCdVuBthEKjP?=
 =?us-ascii?Q?q2PEj/MxNSP3KdRL3LmZJLMyMLs7TZ63jfuR+7dKvwiuwCA7MgtGcdSZlf/I?=
 =?us-ascii?Q?sV2jAZWKD+8wV33CX3uz0lpOayg9NrZTW1fUxJ+95tXTiFmAu8/QUafxgESZ?=
 =?us-ascii?Q?lekpDecAvAt2dM5+fUqb8J5hekEyl1ubnq7YosL4aIjs0K9skzuZqvTSaxIP?=
 =?us-ascii?Q?48TuL5Xa+3CGflDv5rguKVYSOUslHEs1PwNGxM+Ect3ZOzokalcQ9zNPEFAl?=
 =?us-ascii?Q?pkTltt+JKzrmJJqThlMet1fu634CMlmOG4DOFmLBqE+InO19++9UfIJySXdd?=
 =?us-ascii?Q?iw6oti9L8crLbcnT2ZSugA=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fde175-6e09-4460-2c01-08dbc33a02d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 11:23:32.5913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgMt5NjTA289BNOYVZEvAjz91QiONO1LU0+DmDJFlUaZyl4t1syd0eby35llsF/suZhrbSZPNuRJYfIle6nwAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6853
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This patch partially reverts commit c75e707fe1aa ("block: remove the
> per-bio/request write hint"). The following aspects of that commit have
> been reverted:
> - Pass the struct kiocb write hint information to struct bio.
> - Pass the struct bio write hint information to struct request.
> - Do not merge requests with different write hints.
> - Passing write hint information from the VFS layer to the block layer.
> - In F2FS, initialization of bio.bi_write_hint.
>=20
> The following aspects of that commit have been dropped:
> - Debugfs support for retrieving and modifying write hints.
Any particular reason to left those out?

> - md-raid, BTRFS, ext4, gfs2 and zonefs write hint support.
Native Linux with ext4 is being used in automotive, and even mobile platfor=
ms.
E.g. Qualcomm's RB5 is formally maintained with Debian - https://releases.l=
inaro.org/96boards/rb5/linaro/debian/21.12/

Thanks,
Avri
> - The write_hints[] array in struct request_queue.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
