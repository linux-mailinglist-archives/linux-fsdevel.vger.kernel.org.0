Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14D67B59B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 20:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjJBSIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 14:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjJBSIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:08:19 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570CA7;
        Mon,  2 Oct 2023 11:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696270095; x=1727806095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JHF6GCEz18rjAEj8jQ7YKEJxWOKb3cPeC4Adk3z89qQ=;
  b=kyaGMBTzEis+Nw5oWtSM5ovXe5jju5/cx6DZHUKqoZMaPNnQmHf5nxCz
   iV+3CG88kr6qQiSkRcDuMO1z2zIulgWHkhFPTCxBgFIn/zOVSfyHXWVLr
   3fwTWs1lEbRLwvir8RHXifz7UTTb0+3CyZFOlMnTSn0/4YfIbH10Q/3hC
   LBaFhgXFszXNRQPOdpGhcRwdP7cTvBzZNivdvvfk0l4sdbuFml9ZjE94s
   ecpYLR6HA6OQ0n3VdBQQWI/A4icEKrI6GXaj+ur5VysYMdKx7eT1ctZ1x
   SCLcBT1NptHzgDAD1Zz/PaEleJgjA4bqYooSOf1Xlr1cXynBVyBP4/507
   Q==;
X-CSE-ConnectionGUID: DxeGykbmSNCLYpUUO10P6Q==
X-CSE-MsgGUID: 9fE1t086TQObav9r3oQRfg==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="245471641"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2023 02:08:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cx4R6cLPCkPUbc/W9zBG+P/XjeGKvACWh6Fs9eJSR1fzRrI3GM6XMhmabEyz5jAz0i6+/62kZExOetL1w8vIOWqaYd9bSoHwP8zrd1Un6vdPOazZr5RNi1ttX7RwCBBuzWAQ1x8u3BPIdMvU7lT/4iNQf0qGtDl/9j/3sr9LVHS9g4tF/mOExOzgz3I4xjmZa94KrVqaZHdAQRCZKw72qGO6ra0sVmTb33keR1As0gY1fO1c+8hBJL0lr+qboGw23jEbIGHe9X/WKeYKzviBCYOhtAwrj71lvku5syT7qZKDiAiH/AoQGxYJi7X1DXP07uluGJqnOlx9kWUE/kalzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHF6GCEz18rjAEj8jQ7YKEJxWOKb3cPeC4Adk3z89qQ=;
 b=VoDfi2kc0QdfrgKaAya4ynpT6NMJ7CS5iJt1REeZzQe+Fsw7w9R2nLSW2jAFf/B5s3BMszlHjtFuyhXqWuZ8XJ7vin8GxgWEghUwnFAfjKino5RCW4M06F7s2yTrcjSCmmybRgPyVV1RfyumpZw9WfI7xJ0gFpo+HGubSeg2rt226zY5A/U0Jy+RpGznVfKrBN6+LTenBzE6YbwKGBkLqEXalr4XcVOg/mC4BBPSfUJbRaQbVIPfgFsz0CWfXm9edQMIB2+JFnfxZKBhHj+lSIVtB+/BxqeFLmuvyyb9GPJB9zl1p5pe+yWRYUm1h6pQXV+4sQyG44zQLCpUiLXJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHF6GCEz18rjAEj8jQ7YKEJxWOKb3cPeC4Adk3z89qQ=;
 b=ccz5cLUdkKczuVky5J1s5ZVJYiRr1HIKtkv/9KAog8SR9nNzmMv1kHVxra54G12oT2eX8xzUchrPru9EHt9M+KtyY4SxJ/F7O6jWogGen1nXX3CBcpDy8fAFs9ANvyjg5DyTBOUQaTDwK/0W2LnxZMBEbqK8gfq3Py9wflImmp4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN8PR04MB6305.namprd04.prod.outlook.com (2603:10b6:408:7b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.26; Mon, 2 Oct 2023 18:08:10 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 18:08:10 +0000
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
Thread-Index: AQHZ6/bmbhsr5VwL90evUuEgotR0H7A23qsQ
Date:   Mon, 2 Oct 2023 18:08:10 +0000
Message-ID: <DM6PR04MB6575873F82DC187AAFC0CB56FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
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
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN8PR04MB6305:EE_
x-ms-office365-filtering-correlation-id: c53343f2-8e48-4d62-a699-08dbc37289ae
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e3evwdICaNciPNus0oQYssmQ2O/KG643aZN/ahiVfrlJ2emu4yNtv5L5I7kQYkG6Oonc6Trb67/FOyeWUM8u5kIrkTCPvICQF/n2ffuIIjEE9Y9qkjb11ENIhsId98uFpNsgFPwLR8AiKLKinsbH7hUbXuVBNiw3GS3O57ji3pXauINUHJ/nTpSgM5Qdk8SobX5rh8n+ECFPhnhu2Axo4TnJ0+pPy6EYx25QRG3Gqo/w4IcE9/IZJEAxs7aPR6zPen6/1z84aTrm2pYQEiqoUFK8K5ki0rm7OednPA/Xm/9pWTKXUXeefzwb/hp85KOx8ypbu3GiwzrVv64LOkR+bMNW9kRPiNIAz3KDO2JBUsENVkxUPFwcwxzPm+n0jRbM81+d2MqfNT6pWpDpvrNH87uUWZbtmdUFg6OnO+MJRMeN1UEKNFUPM1w376L0RE5SkCIzBXr/PNy63q963j5ogu/Dh/ngPXBI/srN8EUT++NwDy55GpwfyCxPPFb9mpf/MCzlOzz3l719lY+gv6Q50e1z21LqP7Jv1EZhGyPIkH6/1+CJuieGevrrU9j0JFNDnkxDoXw4ReCtZ9DBQdud6gkEhkxWJv0SytgTUWcW4uPtpMPagcKsExI3o+Wn0gER
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(55016003)(6506007)(7696005)(9686003)(478600001)(54906003)(7416002)(71200400001)(2906002)(4744005)(8936002)(83380400001)(4326008)(76116006)(316002)(64756008)(66446008)(66946007)(26005)(110136005)(66476007)(52536014)(41300700001)(5660300002)(66556008)(8676002)(86362001)(122000001)(33656002)(38100700002)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GBN4o0FjJn1zLASpAF2Wky+EA3K2TvwLAgBZLEA3L87psJYBnGYjxLJteXKx?=
 =?us-ascii?Q?bRi7fv8W+dz3gp27mwo6mE1BRoc3Pdn1rH/8simnu8QokS8QNa0Iwi+Ngamj?=
 =?us-ascii?Q?9TNJlnxZWNNDI5FVFk0vPa9Y7jMQL+o1I3M1C/fQOYxW2D/EPkuvqf87ip86?=
 =?us-ascii?Q?CDCogTRf8yOtVx2xPwTV0z3xWmCN4bFFOw/xBAombpE5xlwVEyvsKGSCzhxE?=
 =?us-ascii?Q?/vVrH5oiIwz4cyaIo89PUpAA8oKGTpIWJE9IouIvRgogARmLBPIRwAMfWdH9?=
 =?us-ascii?Q?KHxC+XIdKG95kk9YtUvSreOJ3+sDGiPUxB0DqrTXQ7IfNvVMLJNXqp8Qh5GT?=
 =?us-ascii?Q?r4JnA8NHq7AJbljk4l2/8iq7Bthy+5mUfFKBXuUDhvH+ZXAwKTvIM2zvAohq?=
 =?us-ascii?Q?ieZ7GzsiBM1DnSK6XrGfvw4BYqNyYQ/2JcvCD1hYTMt6oecFlonmGq15d7JK?=
 =?us-ascii?Q?3CPX3LrRkd+Z3zlzWa+LQ1DNHTt4m6tdqmd8KwEr34A4rMmsMyU2WOG9ftWb?=
 =?us-ascii?Q?QX5dS+Z1B1CFzGwU3xUMGNyt+3fhxXXHZdHj3etDCSkkan/AzDr1yhd2W9x2?=
 =?us-ascii?Q?jMIyU9r7XQLTXLbezNItIZfP26CtXAW7X/4vqZoJVGtD2Aoz/dFaGPacX50m?=
 =?us-ascii?Q?/FP9LOY753OCRxqrFIVLovqwqtc9CKyZ7YtHEDKoZyauMhKFWdEUj/ToJNoT?=
 =?us-ascii?Q?1hjgAkgriyYm4khMbHQCAhGtb2bQk7MtUjLwI6/N2CYmy/PQlMd/Ggir0PWW?=
 =?us-ascii?Q?r3mX/kJfsYLaSsRNRC6SbTbIcJvBOxrOPnQAIvC19wMWtfywakhulJVVu+gg?=
 =?us-ascii?Q?X+zNoLEbyCtIXwbpoaGR4aAkXt9pMjvppdgYJfFvz99LiWRx6Wm+ld+xn/H3?=
 =?us-ascii?Q?zF9kYi6GTcwbfS9LLX716U0xPNuL2alsqPTC1VkqsCzBTi4u6fpHZCzpvZ1d?=
 =?us-ascii?Q?ugHywBmgNDQxXTGVlwOzAHrQtFSyW87atK0JVP1V0KtPRMrYqshpsvGxEgbo?=
 =?us-ascii?Q?K9n0ZAvlyVcLYI3kFrRw19GckenutoHDWmtYtPfeSRJIfDhLM6JXnOFqWFkz?=
 =?us-ascii?Q?7OywHKuGu5sBwc3ajjVNBn8QUV0gcoJUn8fVjurLs42vSAuGvaYlb9nPA6Em?=
 =?us-ascii?Q?VI3TlccqaqrYQTqFpD3UhTp8wg0lriqgI+VqoXtKQgWQ8S8baJLBYPMMHSX6?=
 =?us-ascii?Q?yBFGDOPpB4WJdmFcl1sFHfKxUuYWm3Ny7GLzZ4pQT+AKtovgJMjRb96x/JkY?=
 =?us-ascii?Q?qx90ZZSbJerK/merUvD/EieNEpDchlgkwxnaxFdOtjEhlKx/2V9abtzSW68q?=
 =?us-ascii?Q?FCiF4sgDcGjjCd28Fnlfj5smPYZ5soBoEtyPpahr+4iNZD4ppAx/SwOhyxc/?=
 =?us-ascii?Q?28nfyxCS2/t3Nyzrc9DgIlSqbNA4LikMAKP2VcH+lx1aTTDu373Zz6BeSJ/i?=
 =?us-ascii?Q?JJ+gvEDfl1rnp519CNweZMD46NQDcL65dUBxCDPRLCtTW7OpdbU9Mnur46gi?=
 =?us-ascii?Q?r61+1FdayDwlGfjVMuhgs/11jN6066zbGx++4398PiU7zTWNx3KpP2OxWKFr?=
 =?us-ascii?Q?XIwjE5ijwzK+oVrhwZ0ui4ifpn/7zlRTSaHSgKKk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FBLCL7qicT3lhPmx9qHvpawpc8E4mlDwgBKa1xJrvQArhus3bt6sOtB48GnC?=
 =?us-ascii?Q?nWpwe2c76DbTdYe6bKy3ZCz29l+Gym9QGQcWZEgXwjAD4o9cdt+n+7CJugjq?=
 =?us-ascii?Q?ueER5ejmp2WXc/BQ+9fLVl1Z8gE9j2Ukj8Ttt9qnFnUVv0YnC2fU8h/fbGxy?=
 =?us-ascii?Q?ZiM1t8moMdbUEShbyU68v2C8F8QxFldQ2pr6YD8VPbnAQ5jtk4v72EeMyt9G?=
 =?us-ascii?Q?JCC6ISTjuwYDdR1AgW+r6bkGH30EtXxWLfTComQUFDAX0YjGWCZy9uSmFlMq?=
 =?us-ascii?Q?xyWbOXE7CQWQIUsscqW/Ylqb0yTaUBv1E0lOmlbIzhGnlsUZQ5Fcr2FuOXM8?=
 =?us-ascii?Q?uuAaKuGjirfOCI3OGSjBxZupnQVinlF3RPpplADaAsh1q5pm8yq1Rxl+7iGv?=
 =?us-ascii?Q?dfcc9WmEc/+7RBDYJ+lZZ8MZuJGDRmL2BMLs0854nSrbYBoeSWIA4YnS0ToX?=
 =?us-ascii?Q?aFzDA4GOxAB9u1WSBcF84yi5x5JZ0OoRL/iVre0FRxTHrbLOW6uUlmcMj9GE?=
 =?us-ascii?Q?vwQyIqT7tmSJQh1qcObnP1cXQNYmLMYrCr9bxBGgMrqmwc5sOwypeswaYPMY?=
 =?us-ascii?Q?W7Xz1sMS/ezqWqmSbE1ypiIfzo3NJ5dtqQACHrz7JFc6MeRg071CxnG2pubH?=
 =?us-ascii?Q?N42aTCaSys/GbiYHmPSEERolSkb8za/ImlMzWbiBKcgJW8ts+/JR+QmsjTQX?=
 =?us-ascii?Q?ozsw+zLJ64DruX+gZo8io2b7Vu/myR1yVJ/kVodte6rThaSOxGXXtb66+Vbn?=
 =?us-ascii?Q?0VRL/1A+GCmQKma2P9XM5WhZsvhXRzd6Jy03Y3qnhbhbNknpfdw7ZPQ1uDPM?=
 =?us-ascii?Q?LHgeo0iftRXJr69q3svf0Z1W+gvE24JOrQfP6RwAW9hb63kogKUogDXwbicy?=
 =?us-ascii?Q?JF2PHypjTrTaOFzuEaKSuUcDalBGx3UjbunvYh68Icv//hDm/Y+v2CXyMdRf?=
 =?us-ascii?Q?rsrPaWwvC0HUkrOyUEN5XQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53343f2-8e48-4d62-a699-08dbc37289ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 18:08:10.6068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hbx7gAoGqHyTdX/R0HVQU4bZxx+GK9NTT0CR+nRQ71uoXqkRo8zM0ja7arEAmB0wZjB9ooHXswWdVmjBk5jTtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6305
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=20
> This patch partially reverts commit c75e707fe1aa ("block: remove the per-
> bio/request write hint"). The following aspects of that commit have been
> reverted:
> - Pass the struct kiocb write hint information to struct bio.
> - Pass the struct bio write hint information to struct request.
> - Do not merge requests with different write hints.
> - Passing write hint information from the VFS layer to the block layer.
> - In F2FS, initialization of bio.bi_write_hint.
>=20
> The following aspects of that commit have been dropped:
> - Debugfs support for retrieving and modifying write hints.
> - md-raid, BTRFS, ext4, gfs2 and zonefs write hint support.
> - The write_hints[] array in struct request_queue.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
