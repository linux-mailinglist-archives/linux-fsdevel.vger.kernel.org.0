Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26447B506F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 12:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjJBKfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 06:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236477AbjJBKfb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:35:31 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA0F93;
        Mon,  2 Oct 2023 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696242929; x=1727778929;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kYpbnEBs1zpmemGOZ2tKXmuz4VURqDIr1IyO8lPaNv0=;
  b=BqyNH51dr/u46jo8wTLCwRV5RLWC/kAucdQthaElfPqS4sn5bNcMnwSv
   +8/ioLVdFfcFUdpiFM+r0qNhILW6JVaxPO7xSc0du6oHVlF97L+UNIp7b
   OKrvAXM4GPvZwUHfzWnw/QMxR2hUxhpikLkyr+aiclGi4iwiDaMkfapNT
   a/77CJfcV8ZPkUdQ5JPZi47zVqt+t1HKb1iHTBgBdpinehBuh22wywzqh
   3ssaZ5ZggTGcgiCdlamK6uNvigXhZMzjBxksYRigNOPjDSdTAhn+ro3yM
   a4V9aI0T/RkuAPrZgef8/qQgjkySoBANyFZlDHY06pQwFMZLn1zYIBXNK
   Q==;
X-CSE-ConnectionGUID: voRSD98QTOCQxy2LXiQugQ==
X-CSE-MsgGUID: bks9TC/TTB+KkoV401A3Vw==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="245440601"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 18:35:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H71GFfNWpgU88WAsrqRYhi/yTbXl9023gL764tsSBFq43nrPqkXw9EQ6e9qiFU1nXa/fzFJd3TK3+VdB5XEC7LtxpM2+rIacfCWv8uPpDOoetyRzVnJ8t9K6Y3JJ/6p/kfdJuEo5AVJbEa3sm9s0hklg+Zb6awLVYlgKvZ+4ySR6cA/M3iSDopDYLnmwV4nlIt0357xhujXN2xfBRFIWQGvMV3GTbVeQf5LDGsED5H/FN7fn2QJSxrjcOcOfiy276ssDsqEUXFrvfFVYhtfkdDRIbBpBpr1qdYgojrMG5ynLhhZeetjzbhB6dezJA7Tufn5y/1Am51f8oTwWThhbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYpbnEBs1zpmemGOZ2tKXmuz4VURqDIr1IyO8lPaNv0=;
 b=ORCUQlnfg4UV1KlEqnOeY5v3HHPAHsCCK8YJBz/18MGyOjvu/SB5AItuPGCC0WYKV616eOIL5OBNn43GQzeFXPkS2gdsT7kghqA0L3sOQbUhCas+muQLeSjMdvZD4rLkRD0h2Cv8FAO24dwBtT/fGAtwja5oil1A5OiG4Kt+2JgXRuecr3jjT+VQfDEkpNe+hm50FUKy9jhxD6O7nIaJF8XjXKlykvDSgrr8xD397lUQlYMbeSCbauajdCq5RRxb5qNkI6UmV7GTHDzBB7Tt0WeK6gueX1MXWf3W8GMS7aVEaM8Wk+m22ivdGv5VtmOr59sTln3hV/hktHlaOQnZqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYpbnEBs1zpmemGOZ2tKXmuz4VURqDIr1IyO8lPaNv0=;
 b=HHgZfo8cDEHj3qkcXxmnPNoOE3A7DTDZD2/YJxdvcdzF5fRN2NgjkxvHXn6Yy+WAjE8vWEmt8aiEyxBR84RpjKgrMRrzQp/f/Gpi5S36c+ONGCHrMBAL+d6b0ngA30rkhOxlg2JOdKiOp4I0I/+RrONnTcyn8n6VmMVAQVee1VU=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7757.namprd04.prod.outlook.com (2603:10b6:a03:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.11; Mon, 2 Oct
 2023 10:35:25 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 10:35:25 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: RE: [PATCH 02/13] fs: Restore support for F_GET_FILE_RW_HINT and
 F_SET_FILE_RW_HINT
Thread-Topic: [PATCH 02/13] fs: Restore support for F_GET_FILE_RW_HINT and
 F_SET_FILE_RW_HINT
Thread-Index: AQHZ6/bi6PX/dqOS8ky5TY8fnV+SfbA2YClw
Date:   Mon, 2 Oct 2023 10:35:25 +0000
Message-ID: <DM6PR04MB65755C86773AF8B5A387F522FCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-3-bvanassche@acm.org>
In-Reply-To: <20230920191442.3701673-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SJ0PR04MB7757:EE_
x-ms-office365-filtering-correlation-id: 52d5e06c-cc9a-4ce0-5abc-08dbc33349c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LhZGKJ7K088ZSUBL3rJU57ujEZK6xDo+ttYFGkaSeLx2TxDk21MLhHMrMA3ETKjTEN+t9iVFzbMXZzBw8YU0SP28uFr25hJxTPLRYybL7sH7ewrAdSHNmFI2dTqrIYM3vMrVM6hO0Cv90z3cYz5HJUCqpaNkOiij90wsemSuCBLbVXGSLJU/FXjnBZWpd+70wkVVtN8g3btAJmeck+bMyHuvlQXnyuqro7IsgwqdnbeN5ah3G6UeWOpzsUDNx/VO8G2ocO3fLyX9VSPixasMkpfpjR20RixEGVyOVgrIvTiXvNR699X4USBjRQis9uSH1cS55H4FvmLvPdbA/opl4VSY/V15+2PDQmENQtRJvap2/nwD9qBVWodItdxPSjtdRm5KP3cy9/kXDv16OmG3PgUVX37v6IqIJTYlaah5IfQYJvBDWDdo5dxQ5ViVUQ1dOJfuieitk2CqhNPEyuAG7Y1sc2oEAgkwGM3C46I3blx65ec0EUvk1atk/7VsAVSXhvmk2KJpYJYQlOuO81elD1moAGBCKanaqaAISSDvERKnLa6DOzOBTN2cgWsLKIu6ZjMG6+Wf/cyvbJonhJC+UUh1FNzyNUL5H4l10YhBRgmFrh3D11jpX+BTcZMQfhKa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(66946007)(76116006)(316002)(54906003)(110136005)(7416002)(66446008)(64756008)(66476007)(66556008)(55016003)(83380400001)(5660300002)(2906002)(8936002)(4326008)(478600001)(41300700001)(52536014)(8676002)(6506007)(7696005)(9686003)(71200400001)(26005)(82960400001)(38100700002)(558084003)(33656002)(86362001)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k/gzYfStP3ntSpxq7jUbES8d/RhugQeNIU/ilwMufGOL/mLJNw67CruCBLob?=
 =?us-ascii?Q?8xSxDQN19OFy1mofiOZRb9R9mKQQTBA0P7zWhQamMuHcNuG4nzo42mtrKdQU?=
 =?us-ascii?Q?hVO50zJA3Mp8SDV+6WKX1HFaMYXKVpQn/21yWPat00pOdoqfK+8ayEru/Xot?=
 =?us-ascii?Q?X1o/UNACSRkw9CtKws4yxNCrvA8FaAviYi0bvy47EfinfEn6wvnsBhlSordG?=
 =?us-ascii?Q?b/Bdd7W4PMq4mZSvxs6dS9sdxaVajoQwHEnS7ZtDw2/hYxsBzqdXpXVY9Bj6?=
 =?us-ascii?Q?ZXR9JikFgyj8LVujrEyWEe6vzolLij1E1V1dcC633T09AmlFmpLH1FyipxA7?=
 =?us-ascii?Q?BU0qTqJddAgdCK9H82gOSK2unB9p7AwmgfJG1cTtjQepSc2cZ43RI5wC9Fln?=
 =?us-ascii?Q?FAtNa40+lkH3f6Y8ApUmsINvhxFpLradqTkeQhjVSmoi442z9E1nqBY1BXJN?=
 =?us-ascii?Q?p8nrTeFF9Y9M6+CJuhl+/VfIn8XbeqDzDC73v71P+25Xb2Rr1PgImLPje5IY?=
 =?us-ascii?Q?pf/4pOjRbXX8IsJmxh6ZZ4cTHJHat+58ZDaCfreEwUciktPAW9lKDJtEMKFD?=
 =?us-ascii?Q?m6dmU2Jg5t2bQdsqfvTuuUxYXY8gU3fmGsghC3RCj+xiFpTYFscE3zjSTzQI?=
 =?us-ascii?Q?gcjVUL0OmD/64JuwQ0B1+7GMhBneoFjiqSbyWuOE6QwP8cQaXYa8nmPp0rG+?=
 =?us-ascii?Q?7U1nU1PEhk6FyhhzZLXCAO4jBOnJvnhZ/6ija4XkK3bXUoahAoz380RWFnqv?=
 =?us-ascii?Q?TIzEu4rkwAWEzY6tAAFMoVAOCO5PM3XpVpDcVSzC+hU60Vbl/uiRE+mKJIu0?=
 =?us-ascii?Q?BkZhBh8D00U9osBQ13VbpBN7ajUSIL6K/F5Ngt7sB/ARtD94o0zCkRMrRvki?=
 =?us-ascii?Q?onGu0Hflc6IlnpA28+pRvqM53Z31orczi605S2Eihb/QYqM84nlAub3Fo6l4?=
 =?us-ascii?Q?KTcz6lYi5g+8ZF6HJN/jA5p7YxPIsueyMKZ0TldJP1f5ile+qAaDQ9mw3cQv?=
 =?us-ascii?Q?/du8TEzfOU/INBxlx2gv02hi/7p4uQj7hP2iyyqXbCPZ9cVAZLPu/vkAXtzg?=
 =?us-ascii?Q?UWmFhA9b65VGLVzEKyaI6sUKySrhV+wueVRW2hfdMxubS9c6x8AlggFuuLBf?=
 =?us-ascii?Q?PYVAPLM9z8V91jckVM0TDHL6aGefuGOUoEIwjCm3l8WNytc43KTDYGlnFytA?=
 =?us-ascii?Q?BEEgToBYqNTlFmv9fjGI57UNmTsWnlm6osqOnG3BTD3sHLKO3Fw7Zkv+MZQ2?=
 =?us-ascii?Q?o3WlSifQ/5N642a39JMdqpSIatkyEWjwHuWkAtBwVwdJaqtTJqtyugO8czth?=
 =?us-ascii?Q?6xFZF6TSZcfrzr45sOd5WwHBaGl6BtpWqiWHQCDf6QNj9CbwRtljmgVh9HhR?=
 =?us-ascii?Q?q9t7GWZffLNKrEElsIffnaTCEatKYxRlEDSZ95UFWWUPVAIPKblzr93nD4Gt?=
 =?us-ascii?Q?6iNgftLvBQbrPzAWRNPiOx6fvEN2yZ3KhwnAN0QQKdEr4jSE+UXdtSV57FoL?=
 =?us-ascii?Q?MzCL0t8inUqvgSOM9vBXtuhz8tB6xjSEpEtvBtmRbaxhEaMyDVKDbxO0Ud05?=
 =?us-ascii?Q?LceL95Iq5gEBzKlisLbHSU5JgjJwzxLl1S2Nma5Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?i4Lp/rTwrwtfetjjCROQ+4lQVLzDpDWRCLIbpY5StK4Zge4TsZdU0AYvHm/Y?=
 =?us-ascii?Q?5n1OOnsJuNSu7bYFzl9gGEwk0n+o0JHkclyfw1L0uzuoDqfu/4Y7MDhgCCak?=
 =?us-ascii?Q?nH1NQum7iLRs0ncogEDaXcHvE0XR/tt4TxDzkE6pkdhqW8HuSHYihWgWFCuS?=
 =?us-ascii?Q?EpJn04yitWSzbE2+vtKPvVXYKkv4ajx3W+cVHxquurd3WMsf1qHXPkTaGWtu?=
 =?us-ascii?Q?cNPVi4aB1SaUuaxo0+AZeMXuhT3PdrqzqjuLjDyqPvmfbo2Edd4rznlGWxGY?=
 =?us-ascii?Q?Zn9bNlNjbrRsPijwm+cJGkGPdqpnHd9eIv3qs+m+rq+y3AQONY82MCbfq3Q1?=
 =?us-ascii?Q?mHLDTi5UryKrHw1P/rbt25fjds+VmqVpYzDlp7jFge/jC7yalECzEyFxkL3A?=
 =?us-ascii?Q?HThJkRZz7LInoEHW2FPqSlFT4SI7CoUoEx+NqioyEgbJB4tkunGt8bszts7a?=
 =?us-ascii?Q?Gy8pq8OEjS9KDXa/3hHLk9VFuFPqQmvBr7bWL+/IZe2t3HE71N1ivOjagmVU?=
 =?us-ascii?Q?/KeJuMdt1BX64laqAR5eDP3XQh3ArYHyhE8RWGFggDQK1PZQlL79kYF8/JDG?=
 =?us-ascii?Q?GA0rnebbSGtJsu1+4iKPRizCORV2viK8M9ybaYE+M3tzKO6SaSka2WvCFGoE?=
 =?us-ascii?Q?0m1uobSwQmNO/P/UW3/zijgfhluxAoDfj9m39rKE9w0UKPaqmaaHPuRuz76l?=
 =?us-ascii?Q?rSE83lKZCXds03clbijBbje1AqLlLnDGGHA3lZUWIyIscosRTxMvEG1v5ZSD?=
 =?us-ascii?Q?q6KxWGxdlmZvZ1uXE0QpRAB4ZiZcoN2jR5zOFbv5LttfOhVwU0hgYdJU+a1G?=
 =?us-ascii?Q?7VTnccoYVyBLoHJjGDjbkkgzvFC20XGRtgAqdY8snYEGuPhfr99bWfpZxISa?=
 =?us-ascii?Q?G+6CjXfFQkdTC5Gc4xiuuOjbQV43mG+b1QO0qg7TF8gKFgn/gvueVc4YvXRc?=
 =?us-ascii?Q?2jiLFKBcNurMU8osqTl+EgAljM9O5U1CsTwCHlmVqOM=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d5e06c-cc9a-4ce0-5abc-08dbc33349c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 10:35:25.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rhpla+8DlJB5SWQG36eBAnL8wTg7oXbbYbXZ/u8x7u7Q7PelqfqODruSiTGiQqnfJOIZdNyVBx6kX/lnGTIWjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7757
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Restore support for F_GET_FILE_RW_HINT and F_SET_FILE_RW_HINT by
> reverting commit 7b12e49669c9 ("fs: remove fs.f_write_hint").
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
