Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5577B7A960D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjIUQ6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 12:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIUQ6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:58:14 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E623CFD;
        Thu, 21 Sep 2023 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695315461; x=1726851461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W9bS2P7EAF+LEVN7wVyNiNOUnWX5Yz8GIbVX6N7vZdg=;
  b=Xo7DpV5mow3xQHpSPBPD34IgeJPWIAZtts8vx7/0bvAHaIRn074hzVPR
   DOOdVxnbMAKCmFV6e1J4SOXVDeGuMwk+e/RPvUivceRuEyv3RogqgeaQD
   07E/+iFI+h5YX1cnLajy64g9BIHjHa5pNfoUFKzJ0pkuWGT2stOocuEic
   ho2B9qJPIoSZzr1/uTUcOCOJi4OinSTrc/vNb5UuZM7pxj8IYu+vsDbYY
   edm9EteVaL7Wmpsro7X/CejY+dzccH/6fvyZG0GHt+YiVtheAk5xZ8Io7
   gvNalH1w7GiB85qQKEFPaUmXZRvzApVzEmTt+4W+24dIAmGw9vFTHk8Fo
   A==;
X-CSE-ConnectionGUID: EXMemB2lRC2PqEZjjM1QZQ==
X-CSE-MsgGUID: ukLjGvKKQ36Pi4PhNrHf9g==
X-IronPort-AV: E=Sophos;i="6.03,164,1694707200"; 
   d="scan'208";a="249012699"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2023 15:46:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTcsYfm7rFSpZZepBMGWbyobrGr37fetxn1MYAywaYcludNaU8kcetoGexJIVLNMTeGXmhhy2ONOWkXhp33Ohuu5vDQwA/DuaF1Qx5p8V3ueNleMhlgh5sgH/Ewulxb5IMIgENYXHSzAhousbQ2WywhRjUhvnkhElJCE9Vs7zyfNSSSlhWKiqVTRJvhw9C9fq+no6itSp/q9RZ5YRMFy2w8cI/5VIKdfwEU62bgg8sbhyF2Tka+bPV/WssCCV+bTXG+PLpB1ztg9/RVZsrkaEWoMuBIDb/vwLi7avtYnbNwLz7IpC9dg4O3y2Pe+jan+3K5eolk3vySeEN53XhiHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vExDvWIeW8IsQOwQOO8sJ77shdzLlhBXghJmFkWNOXg=;
 b=K5qO0skoOQ0kTJMIs5mr51YZAhCBwgL+QXbtor1YSrrKwoikkm9slI/EgrfBMOPEiEJquX3cW0XrRvl6+Xtevmr2mAfRyL7cFPnDjnPtfHUiQi32z/LtPxsqdNpTzwdTFhfKaW4y+/V8aJ8qZVsm5pH8mQlIG8Uqc7FTK+irJ5qPbdYRs9n/tLcet1X6v3XejWvCzu8Eim4ToXiI89PVYHOnG6BZlqtbBpls+0QqExmw0LAfjk7cV9bh5iMwbn1oj0dRaK+M4Ua9tvtafDvgN0EHRvZiRpvYqLICIILOX9UD0Tu2hQlyY/kYHEFQo8vBcdKOP/zTE0Gd/d5v2ZGPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vExDvWIeW8IsQOwQOO8sJ77shdzLlhBXghJmFkWNOXg=;
 b=uYc6s2k9N+iWukzr57BqB6nz04EzkXWngYgJmpAKz18ROmPaIWKMG2bUWHYsC4AHyDPzWrW0AhapMzbDuVGtbxOEG/Qas7wZGQwCEDoHXAg5IlwnYQuhIre7j2/LGAIrFIcxmqt7Rxr6Sgo653m4+bl5mFIu2qkhMRqFBLgpdcs=
Received: from BYAPR04MB6261.namprd04.prod.outlook.com (2603:10b6:a03:f0::31)
 by BY5PR04MB6406.namprd04.prod.outlook.com (2603:10b6:a03:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.10; Thu, 21 Sep
 2023 07:46:53 +0000
Received: from BYAPR04MB6261.namprd04.prod.outlook.com
 ([fe80::984f:fe7e:1273:bd5d]) by BYAPR04MB6261.namprd04.prod.outlook.com
 ([fe80::984f:fe7e:1273:bd5d%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 07:46:53 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Topic: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Index: AQHZ7F/JFfj1sZp8ZEmkxmgvdKgC9w==
Date:   Thu, 21 Sep 2023 07:46:53 +0000
Message-ID: <ZQv07Mg7qIXayHlf@x1-carbon>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <ZQtHwsNvS1wYDKfG@casper.infradead.org>
 <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org>
In-Reply-To: <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB6261:EE_|BY5PR04MB6406:EE_
x-ms-office365-filtering-correlation-id: dbdb322a-bc4e-4f08-34d2-08dbba76ec18
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lSP0iNP+d8ah1BpoP+JfCvhGUaHJWGfx+UcxLcho1o7w/Xz0jFz2i0bYqFAmQ9haOAmi3f+1dLq88b+H9cmyLkywRCJyLXojpq0EKRuGa9vFWhrsXxlohIh0uUmuuTkhHiPIsbnBjaGIIuXUx6TOSOQoHvTlAKjTfkt6aDLLWHIBWD3xX81uIySqcL/i+Cq4B9Ysyoc8C289AnIAc55oKTe7UGRjEGFbWcAp3l/ixqJvMjgoij3DIJ2b2SNWJNuYciM6lBHUNybXeueCAFIRKaAY8M6zAVYxKZecDPeP1Yhe2vkyWrqOTmZPgjlTXGk1jGEYb/CUfULHtHOgiWTdBDRY6RJFpT+3h4suhb8ZYsP4/3M4q0mBRJrfGLnILpYR2vHaQcf2KUJqy8IEqNAD8zbPmsBd9NaEuXuaI0T7wcL/c9Slri5bcswy2dvf1P9sZ6epo3qOFuQoLinOdL48lU3ekmHq0+7TndtOlrIQPHaRmZFzTFxsmL3S9Y1JZf9gZgibi/1Iku6Ke+3h0c8KnKe5SjzkNBlLHX+Sdfbfu9DB10CH7fCxM9qHUUGw26+p5VQrYJgf8lmprtnAQJFPgjHnAG/u/UP8x3gwtG9s7W4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB6261.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(186009)(478600001)(38100700002)(38070700005)(26005)(71200400001)(9686003)(6512007)(82960400001)(6486002)(6506007)(53546011)(8936002)(122000001)(5660300002)(8676002)(4326008)(33716001)(41300700001)(64756008)(66446008)(66476007)(66556008)(54906003)(76116006)(66946007)(91956017)(6916009)(316002)(86362001)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pyRpplB3MHlyAihwFHCiYbZ2tzUmoKAPAxWWp6nlVkZ3sMZqTC5OYkGmZK5Q?=
 =?us-ascii?Q?F0mUqU9esqeCY0pNMENdMPf0rfiq/I4G5wJFfBoaw0lv7WBaUyjNnWuU4Mz0?=
 =?us-ascii?Q?9Hxowe/ufF1JLdwVjBqcP2dZX4ropY3KmbE9A/Uc2QNQ/sg+zfyHeqFqiG5t?=
 =?us-ascii?Q?kk0HoDM4VqLbGVMsZ5BXCo7OeBWjTMqz4bmX1pUWS8xUJ+mUX1mFM+hK3xhn?=
 =?us-ascii?Q?YpNP/1ARJT2YYii11VIuBjhriBKyvoSzu7s8cwO5gYUfLpEDkoabUnwDe2Dk?=
 =?us-ascii?Q?v1ABYnWCmO4oLiJg9INE3AHkeV86S5FzhyKEyQBQnPWO6oS2AfFu4ujsQTgS?=
 =?us-ascii?Q?E8ojNjKWaAxXhuJ/PSmRe4QcHT5K+npJij5y9m+gnHlHrMT1t0vbvgnYrRlB?=
 =?us-ascii?Q?oi46VsIQmVkpVQm7ocub6k1do5W7O6TxTF5gqa51Rk47avYLznrohRJL/iJk?=
 =?us-ascii?Q?TKfXAnEsmZYk1MGkxe6gTRDZv5IDJlaouqTqZJbEJgi4yuBgFB0F0YaufuNV?=
 =?us-ascii?Q?nk5bpZHv/pN3Nl5H5rOOa/HARb8+aseqEn1dDfCNcfqMlMsKoSu6CgoxweRi?=
 =?us-ascii?Q?VZBAIeUMlW9ObVolHjHZ3FxsNIEuvlI2pnHmWpNW4rbM89ug+mq/hNSUsQoh?=
 =?us-ascii?Q?7M2gGydp/pi5F72axGlNseb50VyU2AdVw7D4tRMGApzD0Tdu13NltNgY4o3f?=
 =?us-ascii?Q?c5JJ6ooXKJVQzEjEOfqK0xL6yqqdSzJyB3ebaJw98O+jcDtJzDdHF9PGg1dd?=
 =?us-ascii?Q?4agr5DonUdWtrXsCRfCSqH1kyO2nEccvJI/uyxe0QWN/cVY/lAV/onYvfIwD?=
 =?us-ascii?Q?bSDYNXSNl5pHSVs6deig+N6/2zTEx2Vd/1dzxwBW4/XxllEXjZjymbGWhQU4?=
 =?us-ascii?Q?K6tfasJ/YnHB5t/Y9L6f6hCqafiPd5rfcodkoj9p1Qwz2VK2e/08FaP5+NRU?=
 =?us-ascii?Q?Iwc0ZK/uppyvrGjUgqjhmu8p6pwVMtZuwMwRPc9Mh/d4hxEJYYjMR6f4JG4H?=
 =?us-ascii?Q?EFI4ivaH2/6KgJZnc9EgeTXkWA6s6xvHK6tPjuvH27havPs5KdAwLVy4uMPN?=
 =?us-ascii?Q?XkeFW9zXSa0cjxxyIqsS+9jNdGKgkxOZ7OgxihXA0WqHCkKlOc5drXLONsLn?=
 =?us-ascii?Q?zKt9l5PqaabYOlhrAdFTNByedd/9dMXP3GoE9BgNMKjyGdGErHSHv0aqdDPI?=
 =?us-ascii?Q?Gu+GIhyn3kdrRt9SCFLlHSRF00G8yZ2xV3xRXhFaxkzAmLXaVEHrIrwGoY1O?=
 =?us-ascii?Q?sx35de1+ZpJMKyTEmX4b62T0lJOfrr/7mDVt7WbIZup6U9hlfViPQnOsoSto?=
 =?us-ascii?Q?aqRCJ2UgUtVm3QfOOLi2cl3g1EZsmH1Vbu6ZkEH/2I9sSPgXGZ4aGCCs3eo5?=
 =?us-ascii?Q?owhuoMSF4gfBm/x4JsiVrRLMdCuLsAVGZBKx+/UJ31NjrEwDASIf/TlRHv4j?=
 =?us-ascii?Q?9uv0qyYHhRQMYAESLu0R91sXTydtbYUR+ux8TYEHOETH5Adir6wBmEfcUudx?=
 =?us-ascii?Q?3L/pDg+cwZqQp5vwGGHXlaICXS3mm7rbLz10NLN/W6j3L2aiuNq4JiegSmmd?=
 =?us-ascii?Q?NUTrF/YFnYzp6XPALBSpZpk9BNUr0MkdnGxmxlTvhxN30DXU02RBRZtBUk3r?=
 =?us-ascii?Q?6g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49D1579617067A40876D70E946FF827F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mcxpkAHCxSUVXeTf4yV9FUiemBdptyB5lgiAMEvCAYYopIWWcIRMvWEpcDpBuoVARfwqnOmUy+HuCBgKYSAdKXhVBO9glDti6TtfLUgYZ1uhIWN8dDX2+OS1Y9Vf8+0cWt+DZdo8lGyMxFOHOWG8bsXaoYDHA9pWgKOdnhnuoS6e5dbMP69uSeLpCg38fw2KrW+FFTFLjDNVRR9wGNLctpF0ennSdTBtmZcgAMgbWoIoJcSg9eX4SRrphHkbf6W6dgJ6bCRNzgcPG5NXaO1PlZFRDRV8qsjAcrhYVFZrYxT0dukDh7b5oz4AW3M9bsyOlOV5Jy6lj5k2guCzEI2+E7pb6n/dwU8I4g/GfJmfYeHcTbR6+JZbZxYQ61Eejmx030TMeWx/dHsNvkeetZh1U1h0m+Je8vVDLKqAja9ahg5oAQv5jFvT60PA1RjbqEMd4c8b957yEBrGc1oD1AusPsT+pHF8ubpGs51Zi6hLQsdqI1MEyTGBGPMowVpDq83efV8tpz9VRtiXbSSDhKEWZ8QkJ+/epd0Pxf8m3/G/5kivvSCEZC4y9wFpA07tuAhOzFOLzrrVwbZgbsHEa1og7b90hZKGW1PGqix38fabixccucHhROCP345OO96zmWC6aO845u2jFSopKIX5ljJLtSWnvWTu2+iDpLUjKKLl/Tk0Hh3+X44NYdm17PgdOF1+RRb6eKZLZRneQn1hPbUf7u8NgMdgu38Rcqyf45o0BPaHp+N7WwHbKX64HnWox4g/lLVLPJSoku0HpeIF2GKviFkknu5izcm+MN3c8XebKcztrk6YbasavtYvgCeCZ3Qq4HxvWf1r7NeZ83n2fAAtQ40G2EGu1LFiDYx+rlAIrk43jcAjaenonVmoWVTqgLYTVwW1KIWMAXKWKbnLbfem1IJdpnlNUVFzCZmVv+cOIG0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB6261.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdb322a-bc4e-4f08-34d2-08dbba76ec18
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 07:46:53.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhmtwwWOc4G/Fd3qaNT+4ixC1A1fo/BNu39pVosqJFUuhjFvcK4+Wa0DV6zl2fHMJM9cKkwMllKHYhofx+Tyvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6406
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:46:41PM -0700, Bart Van Assche wrote:
> On 9/20/23 12:28, Matthew Wilcox wrote:
> > On Wed, Sep 20, 2023 at 12:14:25PM -0700, Bart Van Assche wrote:
> > > Zoned UFS vendors need the data temperature information. Hence
> > > this patch series that restores write hint information in F2FS and
> > > in the block layer. The SCSI disk (sd) driver is modified such that
> > > it passes write hint information to SCSI devices via the GROUP
> > > NUMBER field.
> >=20
> > "Need" in what sense?  Can you quantify what improvements we might see
> > from this patchset?
>=20
> Hi Matthew,
>=20
> This is what Jens wrote about 1.5 years ago in reply to complaints about
> the removal of write hint support making it impossible to pass write hint
> information to SSD devices: "If at some point there's a
> desire to actually try and upstream this support, then we'll be happy to
> review that patchset."
> (https://lore.kernel.org/linux-block/ef77ef36-df95-8658-ff54-7d8046f5d0e7=
@kernel.dk/).
> Hence this patch series.
>=20
> Recently T10 standardized how data temperature information should be pass=
ed
> to SCSI devices. One of the patches in this series translates write hint
> information into a data temperature for SCSI devices. This can be used by
> SCSI SSD devices (including UFS devices) to reduce write amplification
> inside the device because host software should assign the same data
> temperature to all data that will be garbage collected at once.

Hello Bart,

Considering that this API (F_GET_FILE_RW_HINT / F_SET_FILE_RW_HINT)
was previously only used by NVMe (NVMe streams).

Yet, this API and the support in NVMe (NVMe streams) was removed.

Now you want to re-add the same API, but this time, it will only
be used by SCSI.

Since you basically revert (some of) the patches, I would have expected
the cover letter to at least mention NVMe somewhere.

Should NVMe streams be brought back? Yes? No?
While I have a strong guess of what the NVMe maintainers will say, I think
that your cover letter should mention "why"/"why not" the NVMe support
"is"/"is not" reverted.


Kind regards,
Niklas=
