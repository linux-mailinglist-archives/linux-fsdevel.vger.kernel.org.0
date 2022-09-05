Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20C05AD55B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiIEOo6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 10:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiIEOoO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:44:14 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149DAE0BF;
        Mon,  5 Sep 2022 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662389035; x=1693925035;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=waXleeeVcfSZmYd+m4wTqlpZFDsnX+gjJhegtGSk0QI=;
  b=al2swjm3VRDdqp73AHBoVKaFse6GA/KNyNhG/2PtxZiiIMkw7nVUTTTF
   FZwLnbCAeRgFrGGa7SKJxTxmWHaBlQ+vpYKlB8uLwVRsdLSVLDNE6he0P
   YPnABNYlD1wFQEyDCJc/BUK8lgTowyd3lIhzGer5C6mFQpvkNZbupEY9G
   0rQzvXZkToZrZdMcl/WJBSxRPvXVSFV5lNI7VBPTbqmzhVi4RURTA6Gbt
   5kqIcy6IGjY8cPpyGzFbuftoK9X6bH9CNB5tOhNWLO2hRxjpuMJ8rgWdp
   K5FokKWDtH5gHoSOegZRB94OHAaxD5tf78NXp9PnyXfvUCNwZqDqyAzmb
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="322649057"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2022 22:43:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfjDkqdFfUZHSTDseJO4XVVhm59Y4jXry12uPAJFcMj7t4J1hhqr3GbilejYoed3QIqVFuWszsoO2AooJxYDTvg8iU9KtZsiyqbAn8XHowf9lT5JJd//ma9L93Cjf5wxIA8S+sUiG0qXC5Od9sV5KUVAoYbX1dcliyvS0qnz6tuP674dfoL8anUvliOj+Lcdd9HTc+iaUzZARPM1LgoXpi76BMTfvTNrrUbKHs9JpJixL7dBlFH3b9P4CYpoQ3PWivh8HWOW8GhBhXOAwI6vm/zU00+la7pwJ31co0BqAAc2IBjKrWessz3EJDgsfTKoWB8G+uX36fHeMkg9wZnP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oon94/Qi3iNrDn4X8IyAU4qGE3G5pKwFHzRSlv+O7ws=;
 b=ILmesvDEfY8f0fp85ju59Q4I8LdxoaVloVu8t2bHSNtCuRNHDpGmc1zhAY9OlUK3M3NS3lUyBHA9bdJ6a/mA6Yfftdi24P5Uod1OL62jMbPXYK0vpfOiSq82zSsL1FNCvXPQSPfsKxu6/BCLBc2/XOE3fnR6feQ7Nvr/tCJ+dpNVQfv///9ZDwCDpeKPDICbx4w0ThkBK4VjRF18LI4SrGVxlYTfK6t3lvgzjLFU4KMPV72mLny5ZpDpUkDtsK0IGI6ia1i6z2VYTncML7POmi6ybbS3VAM6UZOOGtasNCWmdwW9sbTxyDlnF8vpTo9jZeYokX7Nlsctg9xcCUx7Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oon94/Qi3iNrDn4X8IyAU4qGE3G5pKwFHzRSlv+O7ws=;
 b=MqzSsv3mWzpnKFJoXTzPveb1SoE0UnCkNl8ZcNjSFomlXZ007HiZgcoXW8j3/UmyAa49YED8b+hP38Fq3KP3P2QimxKGMMrkzb/4767OMPgI7YvNgxyWKoyVobdCbzWEKICswqJ0rFQ0YlNRVJdRZ3jw7H/Ks34TrWmV8O1jp28=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6409.namprd04.prod.outlook.com (2603:10b6:5:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 14:43:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 14:43:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Thread-Topic: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Thread-Index: AQHYvdaJyAEeDCU+DUSQMj+EHyZpYA==
Date:   Mon, 5 Sep 2022 14:43:53 +0000
Message-ID: <PH0PR04MB7416688C04F1EF90FAEDC82D9B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-17-hch@lst.de>
 <PH0PR04MB74166908EB6DF6C586B5AC539B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220905142543.GA5262@lst.de>
 <PH0PR04MB7416B4597F2F3426A85295A49B7F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20220905143951.GA6367@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51d7ad44-e6ef-4bff-309a-08da8f4d0dbc
x-ms-traffictypediagnostic: DM6PR04MB6409:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Tf+wIQrk7F7hkl/n2oWLfyOtjmu3yezC11438hn28kiLQUyFpEcU1BDeHzlqjMyXR/3QznHMicZ43DsonLud5palMEeyS5qODwpJj3zOscFozf32c9SwcGExi7FINFYCcSCPAl8aG0r9dj/2qRlvTKgLXTOJM9a3eRPemCR8mJQUbpKf0JjbZ2o26rgxjPjl/tm3fOKkG4UQuwVWb9JX/Ciyt4aJaBg/VQufaYqYyExcR/ORbsfto6xGiBHPJnkukw19B4HFLqbiz/EyrZnn8MhPdqnHqyb5XRWme6Mzd7fgESp/t1G3bcQ22jlLwbbTzWSezv2uixjn3N9HRgDPEerrGxebbOyRtwQQMiYd7TcgEEUuQuAICl4dbuXt3QoFHhh8jabiTEMaI33w4CBbLVbBY/GGqGzqWNBFyFbLBBQT24ndHXJ3QoXp9AJgNwNcxcF6mXkLtb1Bspk9HQEV7mku1ZaWPVqfS9VM5N8IvVNQcdHTbxB+tomJHvg3zd/bmkURT+u97t41Hr7n+O81Z4EpQ6J4xzbrGbDwjSwjod/70LGTKWsgzmvgYpJDMRS7oa1KfJd4Riw6vkKcKRiixwV9ti99l4r/Un+qKY4qzcIOv66mL6zWoK4dR3CH2a7mxsW9h40Va8iCKa5zlMMCwy18h+A5MPyUppziv9ggHVhnHvhkSEpbSEMDwGdFTHpBJgn3B+g7L+EqqdEqjR7byp8OpWqE98/vtSvcqhRGxd+Hy1dT1edIPZRL3MIIBsInGIq53S2VWkLVIjjMm1zZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(122000001)(53546011)(9686003)(5660300002)(6506007)(186003)(52536014)(8936002)(2906002)(4744005)(7416002)(86362001)(33656002)(71200400001)(41300700001)(478600001)(7696005)(82960400001)(38070700005)(8676002)(4326008)(91956017)(76116006)(64756008)(66446008)(66476007)(66556008)(6916009)(55016003)(54906003)(66946007)(316002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BwBwuV678rn9lAKsmLpK4dL/7ZRPvVHiAhvGLwlOaQAVF7jP+xXF7MWZ841s?=
 =?us-ascii?Q?fg51d/2c4gZls35MMp2xVijuKqCQfLmBSxpr/0kKhAIs6Q6Ctbe96BD5gLDb?=
 =?us-ascii?Q?oVQAmnTQgdMXnaa9GwDaJdVJrUs4ZyfoM8TPIZ19uc92XgJQKD8y1MvvhFcb?=
 =?us-ascii?Q?tahvalu7W6SJkKDfuJTtLcGGi0Rq+YWxESHa5fpdxY7it3qYEJ0DDTtqFws3?=
 =?us-ascii?Q?TxIpILVqwTOQwAMjW8oncuKjuJ6HsofA2jbVqGN8HUFaP7XrPGaqEKjPqx83?=
 =?us-ascii?Q?3dHYZuFPBR0e047DKcXGOGzhYVQZ0LgvQIHuZTI0FLra/C7FBn1M4IdbmQhz?=
 =?us-ascii?Q?hRwCLTaPEcx7G0gJf3AEabm8PpOn1DwMOkALsdL4KpHcDgDHacHURm5Ihr4m?=
 =?us-ascii?Q?ECLBXwp30Q220NkMmNOFZzLCLINeByzoDgGh40RlGQR5CoVD6w5t0xy4D+Eg?=
 =?us-ascii?Q?HifygKQUS2ApdkWTCKSW7xmPvabq6Yz0a8R0JmgXrVrSfoFfHgRqPxaifaB3?=
 =?us-ascii?Q?LVE2afXQDyphoVbqTt/qZvK6CYCRZfjd/OHUS8qWlMDkK/1tyG2MFra/HJpw?=
 =?us-ascii?Q?/k4I54ikDRuo/cwbRU9qPofDxvSQG6FuBJoyH5yxQ02L9DtLvpwpan1LlHdy?=
 =?us-ascii?Q?Mem/GN5/s/9XobU9LRIyns3KqeZ+K+4LKtVHFUZeerpm7rqnOAdrcr8F00+z?=
 =?us-ascii?Q?2YDew+sqCVajE1FVQHm7bBWaHJh0/RwiOl7AI7vBeMKwDXC7aIY5k6oSAYli?=
 =?us-ascii?Q?tXnt7MJXdanD1hOnv/a9wDqfcXJkfI6dUBNUFq5oej6oydYmhQi3iNw0s3Zb?=
 =?us-ascii?Q?z9LiANF6izd6IN78Qsf73kZ4wnasPIu3I+utCiEfgtLmU7YNiJ+It6Zsj9NX?=
 =?us-ascii?Q?QSecy35UROmTnQ26yG2T/VPOM5Rq1hLPJn7+Gn3Mwyn3U+Bye5ROGf1bL5td?=
 =?us-ascii?Q?do2Z8mVMdoe85T9sTGd60xozDDU9u4xbXi04HzuDBocbA8qwVwQITbQPGUjN?=
 =?us-ascii?Q?+WKGl9r6E0cv3I/oBBf+1K7MDdihUluFEV6EZ5mfDIetFRImqSjp0DSb2OkC?=
 =?us-ascii?Q?F7VkzMxQl8yHwaVzQGFzTccTPg59R7bEiFe38x7I9mNDkqexW/bWnUDJQ0IA?=
 =?us-ascii?Q?u8uje+qPgIgVOtTskHlrql4VGb18Gtm/NP0Fw6LBu6y56CM2mxjS1kM/qUF4?=
 =?us-ascii?Q?zHIAkHVgGnurcvY2dZXi+qkuqfkHj/6ehy5NWbQqXLlfC5sKzHgLvPVuHFGf?=
 =?us-ascii?Q?EYw3kTkpq/9Z0BqW1ojFPCYSYYNAFs2AZE0bJVqD9MUxHzE5RXdonzxLOyJ9?=
 =?us-ascii?Q?N6EPf2Qg433tgUh5mLeIQxg1p5rUFQhGOZUCQdE3jq/9E/ccdcwkTCrDjilG?=
 =?us-ascii?Q?dXdv2P+pjHLj6DcDi6f25DcFfDicrbmLhixGMraE1whXWuG8xYRL/W9R/G8P?=
 =?us-ascii?Q?HR0zojcToPujY6qF4vOaSFJFf0A7nkZFbmqSZbgDywvvSwO/xRXWczIQiH6E?=
 =?us-ascii?Q?vZMRMH1JdoWjMdXdNdzC0GyP+sc6lbre0b5hsbHaLBYectDcc4pCp5ZI2iqQ?=
 =?us-ascii?Q?PPOXVNRoArxh6IubbwoZTCSVtIHOPTasrOU62kxQVdZfEc/aLTx0Qsv8OIgK?=
 =?us-ascii?Q?vncWtYwY/kM3T19VszWi774yqmAlTqt6maZ+f5VaEHHN46p8y09y07JrS8F4?=
 =?us-ascii?Q?Puibj6+mS0EjZs7wHkssiI/kDfY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d7ad44-e6ef-4bff-309a-08da8f4d0dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 14:43:53.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/TrsLXvoUGTtTavK87+HqwyA/MXI2l2yh29Vrg6DXH6zFrgmfo8WxvzbdZ0DVrnv+DWVMmceC8apgL+7l5OSF5S1DehCVmHpAbmijTmymY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6409
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 05.09.22 16:40, Christoph Hellwig wrote:=0A=
> On Mon, Sep 05, 2022 at 02:31:53PM +0000, Johannes Thumshirn wrote:=0A=
>> hmm I got that one triggered with fsx:=0A=
>>=0A=
>> + /home/johannes/src/fstests/ltp/fsx -d /mnt/test/test=0A=
> =0A=
> Odd.  Is this a raid stripe tree setup where one copy is using zone=0A=
> append and another isn't?  Because without that I can't see how=0A=
> this would happen.  If not cane you send me the reproducer including=0A=
> the mkfs line?=0A=
> =0A=
> =0A=
=0A=
The stripe tree doesn't touch anything before endio, but to be save I'm=0A=
retesting without my patches applied.=0A=
