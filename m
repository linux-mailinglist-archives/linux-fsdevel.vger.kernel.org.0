Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611D35A93D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 12:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiIAKC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 06:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbiIAKC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:02:26 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CA217071;
        Thu,  1 Sep 2022 03:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662026544; x=1693562544;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=B3pinvG9dupSmLAxEKO4Xs2TwmN2iB3ScmqLNbbwV9kJRIEa0UmYRHcp
   zmU1LiwVJbYwX0yEXvmgZsmsZ6VepbbKAX5/1nXoKgWV+I3ZqoahvDRjo
   Lf3ZKT7bpsNxzEfX1zS6/A5/2Y+YEm5H60tcwQZQjQW5m6+xXTFzd7zj+
   LYnGiJDOfOUkj7aBBarmU6K4Eyc++VE5GmLVNAo7i6nWURV1ZNPvx5n4w
   D0pf3NflMloQWk20Mt3n6ZIG0T5V22dj+rVkLVAFMmnyElC8Ht5BX8+E3
   iypMF/HhhVZ1j71HHPT+Gb3KnJ+NiHNBH3mncLm+p96TxpgYAddLLqeTM
   A==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="215381592"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 18:02:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd0YnlpWxIruWB+dYIZnBgOc8qQXAvFCwPHl8tkPOVF2nXkZC8jWQofjGo+ieutiM/xMfqGTtrT4lgREjPcP9mWa8wKP0lHHjZbMwQ2Li9sQEZesOkH8fIETP+q4v2uiGJ9o5YoZnew1cqlMZOysICU4jB9fL2r2xWTRJYXHticBq9iWDYSoIRxsxTSR7lksUOm3/O9OkpXxf8nFvZMt73gU5lUeHg7Ua91zPVi8Mf9jk0XTSh1EISQK1X6xvcOziB2UY15tVQTMHSn4HlCIb4tiXKtWADzkI9eqcdlWWfeAQYfsLd8wsz11i3D1XqCBLYxE0t68aMlz1V+mqAgH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XD7Iaa6zc8TFokR0yh0zazPbGBFPYhZx7SJhOgHqWvy7POeIWSfVF/Z7rEch/FgB6hym/FJojxm1nBsdxLxrZTIDMqcbTmeOeVKOzBK1WUHb9aDnuvshtHl40gCcp2xLROZtnmfd9bWMjmCli+q+x8HCQhX0wVlFRjliFXhQuzO7Psm1Jv5/fj3jbGi/OQtsUs+avpz2h2waiyTZy0j8GP1xIHEz//+/k33Rodq8dUQSEHbxlyOWKEBRgt+tEsyGPdg6GeesIuMeTAbTVic0MtZ3YF7nvbF3rs38HMpT9F1v9ytnMcJWDtCwnQgw2/djdDDB1gv2maPtW2jGQit+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Uwazp0h3wbfTjRcGPBHSF/Nm3y1GU9BqQqXG5xHeYVwHTmh5tKaTU1oE63A7qy+FT2WZd6WGGEtMbeXmnrmM2UP2lY4BiqNduaI0ntDriZvzpDcvwwxIWc1PW5a4MOq5UGaj92LKUdyNzJdiU6hrvI7BdnoVySRBbr5RGVu79w0=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SJ0PR04MB8358.namprd04.prod.outlook.com (2603:10b6:a03:3d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 10:02:21 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::14d7:cf0e:219f:ba97%6]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 10:02:21 +0000
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
Subject: Re: [PATCH 13/17] btrfs: remove submit_encoded_read_bio
Thread-Topic: [PATCH 13/17] btrfs: remove submit_encoded_read_bio
Thread-Index: AQHYvdaBmzOPMBZXWkaKSzVNFgFypQ==
Date:   Thu, 1 Sep 2022 10:02:21 +0000
Message-ID: <SA0PR04MB741834DF7032866B36D63FC59B7B9@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7fd3499-faf5-465e-4177-08da8c010fea
x-ms-traffictypediagnostic: SJ0PR04MB8358:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwZTMrjwOPVf5+OXz3rjjQLgIWIC9vQrg7qEPSyDfYg8IQgpNdKR4XgbYGRPN97wc+YeTyd+n3qpRdfMecvhHOF41xEOsQJeFvrGGEkM5DZquvRGeHJ28eU80n+t+zmRtybdMcPuqMb5ZOw103ArygScnoEO9yGfJlxoIR9wX+Y9A1fq50WWm9iZ5hxLtu+E5V3e4dCRjwDW2En7Z6WpiVwFtEwykhq/TRqGYsCe3wwH2kO3x7k6ZLRuSY0n0m+FAB2GrK7XsyLYfIaMDQzrPDem3OTzYoggCmeja9YCP5VLuKfYANPHZchUCV1+zRAgq2zKHOuEAHcJACYkeGetXih9xec9P3qiBwjUVIwA1rtb9IDx6XME7JGNUL6DrNUn24ZpFUdg5xBa9Q+uacP5dG/DpfUWuowLV+9zxGSBNxj/a8Jz+uquhxFhMZPfGzu/Zr0oxtHsN/8rtLuwgeLtb+xH5b1TJVkM8pNeXr5CCzsZTPtgXtU5IBW9lWGxkn9ecWAkJAu+QwH4E16xrcpb7QWvlxvdkxprlVDqF5T4E0bnEbSmHcZWe6qmskE4zFdptZJviDfTCndoO3HI5b4sQrKyKXYz5UYHNQenKSiws7m2GBX21ywRZsxZ0+MIQe91mpobvv+ZfiVoQJtWC4G844SCilk/Q1T6JKGWQi6csw2f0MKzqy80o9gWgxNbtlXrg5IzL1CGz68f5Fusiq7fqfcOLBxeKDMQkPQXUinqUR4NwNs0qXdzfG8xgoNEhuR+c8MWJk8W+0cB0QGxugRWVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(9686003)(4270600006)(6506007)(186003)(52536014)(7696005)(7416002)(5660300002)(8936002)(33656002)(558084003)(86362001)(26005)(41300700001)(478600001)(71200400001)(38070700005)(91956017)(82960400001)(38100700002)(66446008)(4326008)(8676002)(110136005)(2906002)(76116006)(66556008)(55016003)(66946007)(316002)(66476007)(54906003)(64756008)(19618925003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X7hXyKzgMTPmZlCSJz4C59i7e8mzIPSLUwef7ztS8VjCpak3pC8akC686iaf?=
 =?us-ascii?Q?Eo5iQYDsHOTDxHSCUWLrLhYM+D3yTq+1hrGBGa4r++1DFzcM48VNwkqmedID?=
 =?us-ascii?Q?9dh9EQptD0dGA+YxNMd2tWQY7fh7HS5rlaivj6q4Px095XHRLAYMGFN4KYu8?=
 =?us-ascii?Q?8cy5glmET2zH4e/wvRLwYqpvgVOGr62rmGC9sD52Gw0oe1wKaELrcxzErFud?=
 =?us-ascii?Q?DhxzCWnc6iQiojFr1nTtfoyb1igbvKd+0/cc/ZGUWRIthTnZJxDcU8yq4rMB?=
 =?us-ascii?Q?5aEYdUdnZXPZtqyNZbdRaCj0KJA5cUVkFovgix8EZfVF+6HxhMRYslfCzq3H?=
 =?us-ascii?Q?Atp63UDD3s5MDjpP1QHUqaxIZ5IQxfJBk1TAOTPf2p7cwNpZFZH7PXAJ9D3s?=
 =?us-ascii?Q?uj/voTyAbd5Ec4tfztEMO+7vUfGWunssbjtVS4CdWbfpPsJwXOnLMv4ivSif?=
 =?us-ascii?Q?DfWmFvjtZrnwLGRNJYZmgOuBhSRDRWGjL9kpZYi4dMDTf+q4Dn8asYuHIdsE?=
 =?us-ascii?Q?Oudc0INq05GOw1CIrZTsZprFtto7T1gnpsgb8W2ifiDrxgUKB05Vid9IkGpZ?=
 =?us-ascii?Q?2/zdelpPZ7vK/v7P2P+p4kq1R/JwuA61CPYAm9DOTqBSEh4Mc+LY97VXhAzq?=
 =?us-ascii?Q?hzwcI8EXCOrn0sgJrzbtRbz28Lr0J9UEoA7ys5MB5Mrq5yeMdMjvz9szpxdy?=
 =?us-ascii?Q?0kWIF15baUVGXiVM0YAHAFwMX/oGvmb/2/rExHO5JAK5ntIFYchdMivKO8l9?=
 =?us-ascii?Q?vcpGJR6OjXXMhWrhPgw/JM3ZG4dM/rvJOD0sb72LNFDB/XAvOFLZkTUQ342R?=
 =?us-ascii?Q?blfACat0sT8xEmw7j12sGZWjjeMXmIVmNUHcFILVA7bduCK/9iJHTny5N0Lw?=
 =?us-ascii?Q?ROfSrlchtKCZP0XqvA2BoKQpCrRzmctgMDy5OPnJVeKaEE6L6tbGf3ktHzoD?=
 =?us-ascii?Q?ZgubljqHlq56zhvznEh8zHNWAXVCeeoD6umr5yzrHhpHp8af0NKLdDyFGtFF?=
 =?us-ascii?Q?8zrgzgTwS2sYMfX7PXHH4qFjuHdixWX/d60LkE8XGwVnfb8gkrXlJHaG/RuH?=
 =?us-ascii?Q?d7WeP7QztOzdtkK0MS8BakB4X8ETyLlvzWoPDmfFrqNzgViu1M+PvD6hDv51?=
 =?us-ascii?Q?VZJKZxlIan95/F/LoqHWrotYp7U01diSM7TsQfGc1YXiQPocoEr0RZjrBWv+?=
 =?us-ascii?Q?E0n0p7UWebMbHczX+TAFw1dC6WgZxa4TpgidDORi7PgmZSFR5ACr8/JZNr2R?=
 =?us-ascii?Q?hXLKs6G2p9IzC1WBUcPSvS/GoVB/vnvs0F8/zqSvSU6GN8TamqbyjjOKuj7e?=
 =?us-ascii?Q?jRJBwXGh7Dt1Age/lo4KbfxeCLxqdG25ahrl5KYMHcVevk2WwrEdeP/zTabM?=
 =?us-ascii?Q?6OYbCP/i/d05BUo3cZssWRJDFbOE+aHDELFO13DoVj1dvwl10mv2YTChPjKo?=
 =?us-ascii?Q?/fdwqR+Ye4a+o2CymeVKaDVl7hKKambuoPC1LDcqJ5dYo2R//8iRs3X03JjS?=
 =?us-ascii?Q?/CvzVdzCmML3euc1+lVa6T0clKYxJtXtT57ocd25JTMWsCGO88VTO6jbG3+B?=
 =?us-ascii?Q?cDrR5gCrCqNZZRNiGfFtGTsxAxmk+eXBee8+HDHgwifAuCWWExtv5sGjVJmW?=
 =?us-ascii?Q?EATfQy53uhJd+ZFScvckfJM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fd3499-faf5-465e-4177-08da8c010fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 10:02:21.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S53LYBeJs7bdQ5q0buo6cpWWXvOkgW0lufiJg0kK0kUvxo8kwQkGMXFVDfhAxhPGtnFpDgx7OAaPmn+NPMKeHWCGXwD5X/GaJW+/hd1q0Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8358
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
