Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF35A9391
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiIAJr5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 05:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiIAJrz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:47:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079E11243E1;
        Thu,  1 Sep 2022 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662025673; x=1693561673;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=HsUniLHP6eP9La3bn+0y7wq1mhoyPAYeAZqar05RPjLxS3eFhHKyw2er
   zjK0YTpC9E59UicTqRhLj46BLNS8V9HpPbreE7bloYT6mI563plRfFijT
   VdKMUFn1lU0u9771jbOTn0kYGuuZKPcz2yFJ4KcvcluSDPPhc7bIVIazG
   0t+E+P4sicTm183mg5BqPszF1hkFFRikmRTouZkTY4mesrVk5gFMCCTKR
   t3XBbS+tz23EkkHSsaIvZsKpj0IBu3QHM3A4hYy5YaoH2K1rlB7ONrVE8
   eLvReqobDw4uu/i/lhKAq8cMKchPUWdhlKMbT6+Emai8stVpX8Cnt7Sj1
   w==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="210214178"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 17:47:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+Lnli+oE8Wc9yO47h7lqPcrBAOw9vT4Lj6NjImXp36CAX6Na/BMKcJIp8TNX14h3watcZYzW2UoPcdRIjbwGsF9a26ML4ThTDZHLy6xI5a4aH2DfaSFWClmwwaw00WyusY7B5H6xov6Shy/cPRPG2DkLbzVjXkbiJxYVUNBzP5auC/V8Nf4Bz2EllhiuhgD2EZlxtBSFZWHLiSNDI4krhzfG/zj0L7RPQ3KAs2dZBhT41yvKqN1/I/IWVSwwL1phEjqKHGjz526Sd2/4wtCKU5otbh84m4EflBGHMbx5YW8hZFx+vcjkzfmr/QQ7k7nmvVb4D4z6O5bmIes+pKUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bXJR+qqXWIsD7Sn4UnjmcuitHJrvewdMCMiYDb3554eRkC944fhE3TZFI0D+iUkNRqFsK4NQJ6zXkrO2tIcPdpKyj3bERU7OC7CmGBrsv6sz3Zdb3cE3y7qBaAyTzMBtt9/IsxWTCwW0JlAi9ICWSSJs/qcufVd+Una+Br7flq2l9k0bX0adAfXh+/FFV8Ng5GQB1xMUkxTvca9qHniv6kw+WB272RzxaBzqX3r4t3A84cMR0fNOCgn3CLBEKx30uzPK8IxkM5kZ42jTz+DQ4OpXsd3Yvg7FUyuIbDLHpzEAkPO+Jh/O9UetS96HzcZoVvfwcpqMJP+mj+BcJgh4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=mcnLG8Yi2Ui/sB7d9p8vqcm+qvvnOM/rQpX6aYfv7N0n/pSKJ1+PgzmG3GGY8/jtDfbejDlHXzZikNDxqD1eOqKUemqD+zCJ6mIOEoqW/U3b3TbC0U6qh/vEzC+yp2qLRFgs8Jy/rKQStDpHEk215nPVCDQdrnmt6GOQQaFPXXg=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by PH0PR04MB7884.namprd04.prod.outlook.com (2603:10b6:510:eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 09:47:52 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97%6]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 09:47:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 07/17] btrfs: allow btrfs_submit_bio to split bios
Thread-Topic: [PATCH 07/17] btrfs: allow btrfs_submit_bio to split bios
Thread-Index: AQHYvdaE068lH3L2N0OuUpo2G+LpLQ==
Date:   Thu, 1 Sep 2022 09:47:52 +0000
Message-ID: <SA0PR04MB74186F942BBF295571E76D039B7B9@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d93b4a56-57df-4faf-d8db-08da8bff09d1
x-ms-traffictypediagnostic: PH0PR04MB7884:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6zROVq1hzrlHquh5cXmZ/+zpYGuJbIn9XwdbAdcqssMKMWd3ZEwjs1AfJNMeamDfSv5zVHt5hu03uzKSMByrcmheH57jeFiRCKdTdl82IA7T2fwnlD5ow9IQbaaGt6T0qvrP3Ia6rL1Kcqs1CYSyiwpWpyf37jZm9Ty5L1nlxq/To77ProIq9V0thhCyPnoB4EX4y9vtf8MZTLL1NsVAMB4lVf4F3yo4BWUi7HwuZUb0pUdv+zp7eP2EpDnqJgDkk6ZpbKvCHu9lN+NzzWKsLfoLxeRW0c+QfH8pu8ftfC16NzuRm6PQs65Tl6NgjIJXyvQpXRd8pEMJ6P8918RB4cVx0JurLZ0gA8GmnemSguHrxwqsjO5C9WhVHIrY9wwLmtsgiD6mE9RvE97oVsm2/EPindL/gP+pGNXErCGQkjiG2N+0WYeH2zKQXZqHaytA0HSccM+RqiDRenlzNr+MFCovHKa4J0vzCIJ9I4JCGArbyh0UrKLbL/AoVcYQSiqQ3L4TpGqwqPR+ZWAZU3RTuFHZzgQ4hT74nCh9WDZvTuTuDI4Els/9IC2IqRQCyBmjVR6ziKCYXxHtQo9I94ZqIRh1SceMadAKff9/S6gSEwS2mKFQA4JaSV4Idpyb1kEXjAuWyaFHvbFz/yF8XtdKndfpeek4pVzXdjUEnE9HoxJxxP9qzPia8qAGyLYeQSgl0rltPbC8ptaw8lpi4K3N+kF5Rta9PALCI9wnrC1xb9MY4tP0uIGbwoGnU/thjNFCOJd/W9SyVmxfwgyATHYDiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(71200400001)(82960400001)(54906003)(110136005)(38100700002)(316002)(122000001)(38070700005)(55016003)(19618925003)(26005)(2906002)(9686003)(66446008)(4326008)(64756008)(52536014)(66556008)(91956017)(478600001)(66946007)(76116006)(33656002)(5660300002)(4270600006)(66476007)(186003)(7416002)(6506007)(86362001)(41300700001)(558084003)(7696005)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ab1pEtqKtnx3r9S1ApuYr5txTUulfC8kv8FkkwbPdgUV0lFU5Q69Kxl0g+Ms?=
 =?us-ascii?Q?MFpmxjVz2ZRPePkNKSqWthYx1HkUWen89QpRi83jO5FnvTAAj4B0kfBom/az?=
 =?us-ascii?Q?0Jf1yA5U8padOoX0ghd7qv7iMrpZlwX4o0e0hw7TzVj9/jbuu4CPd7ZdKWJ/?=
 =?us-ascii?Q?KEelyy9szWzcefAplHjs/+3+VLPxyPYosvn1PvDntBxoQC4caH6wR+9NpmNa?=
 =?us-ascii?Q?xzDQh29yKhlRvgWfOKLjoue0TFncFAbJxfu0Mlzm51Hg03Q4vBQKQ8B/Ggk3?=
 =?us-ascii?Q?zz4Rxx8LEpwehBOa4ekuVtHyf6zWVQoWalzk3iHtN1RcBMn/IpyNcSRt2ERl?=
 =?us-ascii?Q?ejXSBPp8T4lzZ5Ual6fXF6CbfUAcWyiB91c5XrL16CNUdk/6TUcxzZXT/FRd?=
 =?us-ascii?Q?LnzRUl/SJN9r6Hd69gOWKdjnluDQxj5VHmLYcM07DLT8LcNJftIXIIlOL6NL?=
 =?us-ascii?Q?VCJC6NQjCYZOqtbu1mIXgEpzAftCuDnmdnRe+3L87wM3RvROtV27gHWh2kGQ?=
 =?us-ascii?Q?/qC9/r6S9M2wD7oPkBLhNTmGO8q/1slQAQoY4k7FWPe8D6ft75bLPnEvP72I?=
 =?us-ascii?Q?3GQ5cafr6dxzE1aApA3OhQrrtSOslNFASmt0y8m0QwbZaSG2ndD35lZ/Xud/?=
 =?us-ascii?Q?tJLzPlk0cHtbckhjJYMER/Aq3CNERXEEi2Ny019kdIxiMaK2UqwS3IjgueLI?=
 =?us-ascii?Q?Uvhr7KSArbNmmUyvJWSND1gJQV+gdAGRmXbcVvRIl4a/jjr1PNbLckLFJMcW?=
 =?us-ascii?Q?0rak0sNE4TqC9j3Holr/3kkw5uyIxmQRBiLOmEUA3DOpPBlmyKkZvv9vFdpL?=
 =?us-ascii?Q?CfJN3BskCvmH9D3FWCY3mzHgaI+1eqsn5qS7FFkQU+fR7bmNuq6BWO2Jmmkt?=
 =?us-ascii?Q?MUkhrkE/2awUSHHFuvxu344Vg61K9K9njlCVYDXswk5N+bqUcvcD1JohbU4i?=
 =?us-ascii?Q?Kv2LfIeJm3qklgSrXFhcO1ZT+AReRtKloCQjY1Fy5nwMzIzGHpwByUBSeEHH?=
 =?us-ascii?Q?k4hwVT6KMgH+Qt21gEeocjbkngnAPS0V2WCd2VdfEhFLxDZfAfzFiI6vH936?=
 =?us-ascii?Q?ef9GDQwwIMVkJCgPKKb70Z5vW+xxKLNR52mlft0dd7mnIeIIsln45TItzRtF?=
 =?us-ascii?Q?aR0zyO0cgjtJi3fxERHIRJqRfDSKIYSko9dJlVt29vLQYiWg/iE9vT7vkmWS?=
 =?us-ascii?Q?XtCMDn5Mhso80tqUrMBipouthbf23jOH8kor8Ob161QuCBBU0CMJac0Tjy59?=
 =?us-ascii?Q?pwoOMbCDvX8y7Thtcx2SN3cflVZoQxEYFORMHq79VWjB5EjbkaRdpj4g7w1p?=
 =?us-ascii?Q?RZkL0oAkniJJRJI0VsiBXNqu6xIlG/RWIub+2wDJ5EI4L7nX69In6RcyRsgP?=
 =?us-ascii?Q?OU9shjERWjrvPxcmNq454AVdUTndZHf3oFL0aoKeQtW3CjjPxh9PkUtuLV8S?=
 =?us-ascii?Q?8+wuR6Kty2kEN7rufUumLxnUOVFiA583i3Pq7QSYo/0V4YlDbGTICLli3yF5?=
 =?us-ascii?Q?ov9WJjFJlmISUD+aNKm8Q86pqiadQotcZhCQ0UXU6NWJUx1mFBQfLPEDf7FW?=
 =?us-ascii?Q?kvmw+apPUE8R+RAEyG6dOdgXed9MSAFCAxFsK6ogLrb23yLcWFXNuInt0tO+?=
 =?us-ascii?Q?0JcWswW4+Myt//iPco8IB2s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93b4a56-57df-4faf-d8db-08da8bff09d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 09:47:52.3858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UZ0UioLFcst6Rgmr1b1/PrHTGjjWH03kuDffrolyUOArXtRdY5PSLbb25e0EOkT6d8DwelnEgSuPOXZmN1g44l6cV1ydtocfTu7mA/Ij1aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7884
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
