Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC599542AFA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 11:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiFHJPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiFHJOV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:21 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE781D684B
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 01:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654677328; x=1686213328;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=prB8/lhDmXOqLjHlfcAN93rjdYzsDFy7lzWtGj/EKno=;
  b=MiBvjS7FfotUxOkDxxZzRA6bXRV2h1b198qUDUb4ccRq65jhXLOymHt2
   2jLZakQfPdjKsnFhTg6CZMM+nwVUwcV49PaG1+PsO2x/hP5iNL5V64nNh
   Fz0uCBVnanaOMX1mlQJlMOxFKbNMH+L0B/3jVFb/jD/Us5Qal324ZPO+5
   kAyLBIYHknXj2EBX/C6ktuD4XQjamqMJhDa5XE0jzuOn24FgX8MyHe0yS
   C89x8Oh1SZPC8Wavl3arTUFUCbkPV7PHgECnS+/sJbYDxZ7ICL7zVwD9H
   PtFpjVU1WjYLjH3kpiLksWRoCkjkDeLDK2UFnc39mC0jZgS4eismbd4o3
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647273600"; 
   d="scan'208";a="201304958"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 16:35:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaOXXNboEBIEWrwCV0D8aHDC07kTVu8qMQT4sbsHnsNwHkJ/GhSNGyO16EA5+D7LbbqjhjIV0jrXhJFuIkci42K39FXUzrXFmtaGHJ2iqGMEIQt9NshgD94TyBHpvImtyinT1l3zMDiN378+1DQvHpRoAdNMlawMJev2TC4kkFowbzs/8FWNUrTF++2qWoBKErVXIE9dXVFgG83K3Mb2IkamWHyimLR3pZVeBKiqJoI/5H9Gc5zcVOJXSI193FnUSaOD5rEBMTFMoFDSDtz6dPdWSTAWwcOF/rOK4psxpsFxKoFpRbGsxCVZnWy5+u0fRzKMWhWPs17VwG3xl5BD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prB8/lhDmXOqLjHlfcAN93rjdYzsDFy7lzWtGj/EKno=;
 b=G76ho3JwcGPRueowxlU0J62mVWw7umwh5LfrLbQS8hnnBi6eM6MP9hJPPhTkRRkGKcYqiY63bPRYcmN4EGhUMKPUSBlpwe+Whgsg4O/hDD0UsWlMzurle+SGh91EXcUO/socqLzbhFj+My64UKu/DbgJBz5i8VMkyoKmhbQYnnBUukGhrt7ZwXwG9gBI9jpKhhZNyDx0T0p+d9tmtQamGtozyUUuGS+UdgUbh1A3gC/IT1xrr8Ikp3/7VW/ugvETexyeJNBPf9HKMyUOcBdm/H9f177lir1BFi5IaeI4kr6ZCYF2q4pbyywLaPZpmjyQ0yp5ePcpDkbxPpp7cqlrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prB8/lhDmXOqLjHlfcAN93rjdYzsDFy7lzWtGj/EKno=;
 b=opFdogbgnfFBPPiVNtMua0fxbee3mYTfGPRmrCG8tXRDpA/cGUbDWl9gwIa51rf/cJTWFuNR40cGS7w06mrTMJSos0RH/0438qulcGCSB4XDlxAAMsuTLaS9VO7J/hIhcMHq3M7jhGC/dEBpxSJGVpgMJ+j2N6tkr8c/yQATltU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB7949.namprd04.prod.outlook.com (2603:10b6:408:154::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 08:35:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 08:35:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/3] zonefs: fix zonefs_iomap_begin() for reads
Thread-Topic: [PATCH v2 3/3] zonefs: fix zonefs_iomap_begin() for reads
Thread-Index: AQHYevQlPgRNsVkwkUSoA1k1pmSxng==
Date:   Wed, 8 Jun 2022 08:35:26 +0000
Message-ID: <PH0PR04MB741682DC9CE4A20A4215E1B39BA49@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220608045627.142408-1-damien.lemoal@opensource.wdc.com>
 <20220608045627.142408-4-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08c1ea74-1e9b-43bb-39cb-08da4929d61b
x-ms-traffictypediagnostic: BN0PR04MB7949:EE_
x-microsoft-antispam-prvs: <BN0PR04MB79490EDA7104CC81DB4141409BA49@BN0PR04MB7949.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyqzQteM3HKKOxDleeqWteQs7u8nygEygMnMCdRXZtQ8Vph5O3/XGUAGZCqAc1vvOZEzJ/yfYiiVCMbnbFRkaoJ40N6qdjIZ4Q9aJy89QJAoTVATCY4NkMHp4mqUVCLwmQgmfZNHbAU0T4FhyToAuy7fP12Sz4V8u7kGFXBFIKZPmpg8ERI1nrZieDOrUeU/tiZ7SGIr+NNT8Qf+eju6xDkZx4Z/r+BD9WGPrU6u3wVsh/7UbYG+44aFP7vfqo+CvesbuT7QfeTL+qp0wZXTU3uUeHA+2/Qcec52HtEytcTpeLMag3Bb1jOeAzD2JkPlJuLAC842wZsrc5+G9aX8gT6BA3+nJypQz9kaD+Yw04cy7vGcFqdUpC65TbilRqwPxTjHUwINtWoUu179U1PUqLsYH0MuG5s+t4X1aA2C6eyBzRah7nKuzg2Lb/SqmCeLQBG8prDUsWyUQEb6JymRIeY/ZMytgV7YzZc7zRmaYUqYnpe4M91nlRVmX0AAHDGKoMhIkNKRK1iDLoabAIv9ObpxZ1if/d4+NLYhu+kFxKdiesYJpkVMsfpWqXCyIZgd/a+NK2jQ0v871GqUAFL4lQKpXQR4pNGNRA1Qgp8mbsQL9HgsnaWGaHOB9G9j+8NWaS8h7hjE1+5Nc3efD3sb4Zh6GPN9ZZGJWA7O2y66t4B3yU98LMzCzAB31R3QznK+2SB2dEiewU9Ij4QXK5D49Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(53546011)(38100700002)(2906002)(86362001)(6506007)(7696005)(558084003)(71200400001)(8936002)(55016003)(122000001)(82960400001)(33656002)(508600001)(5660300002)(38070700005)(52536014)(76116006)(91956017)(110136005)(66556008)(66446008)(66946007)(8676002)(4326008)(316002)(186003)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kibg+12Cv1e3tiFduS/oqHRRXKDGB+4QcEVu0N19SfGuxgfiRQxWb31QTtIJ?=
 =?us-ascii?Q?IdkyzzkYI+qUf/lLCKXIoo9JdyJBqfauQXanwdPwgWxcU7Rc2rutO26lq11S?=
 =?us-ascii?Q?WoInenU0lfcW2FsQdJ2xsDSnmXccGN5X3vxZDrJwK+atXKtT7zQObzkJ3ma1?=
 =?us-ascii?Q?2zx/ljdu7Ndz/yaTQ4FSuc338ZxWiWVjiPH7yNGg8k2NWQdS7xt0HlfbN2Gl?=
 =?us-ascii?Q?qSAscrmh7sh3CVo8SGbBI4zs4KjXmvO0K2exT6NA1S1dLV97hGIRVZ4tIXx0?=
 =?us-ascii?Q?w++2s7Ni2JWr/d4PxNvRZ0WcsELhKG2oPNSqUFYBD8cLxSGMOZkOR4Bhls/z?=
 =?us-ascii?Q?mvtnugaYUxgfxJkRYGl7kpMfm3nWlp0bIiu28pNkouPMqb/8PYxQ0jhpkaGT?=
 =?us-ascii?Q?4x6ZLVf3nbU6UpSCG3gQqzYDBCaIS6M5LTFchnF0WfR6dL0xom1PZObjn2i6?=
 =?us-ascii?Q?GcKBYdqIh/6jAg73QdqLZ/zTrq6HFUtgtK9GIw2JgriwmeVu37Ztz/MHiu9X?=
 =?us-ascii?Q?t6aB8jKEwsF72WHWzOaSjFi3Ehw9Y4sMVeQP4DSNaYWe50bB3ozwTxPlDIgf?=
 =?us-ascii?Q?c2T7AEijRFiRsdlFT0brc6BP+f1SNGiQALxiYDJ6jV6qOq/NCNz7HYUsuMcJ?=
 =?us-ascii?Q?Em/4UTPrecd3VwJF5tvIsoCut8GpbZ/nbrL5SWVFxQAybmT2mmmXZQQD2CCC?=
 =?us-ascii?Q?yTUFhNb9zmzh4uRWWRIQeNt1/JmffoxKZSGvfEMlSPoVZINaMyDZMyC0ULsz?=
 =?us-ascii?Q?gBLe/COhNOk7/HAV4nM2FeKK35CjC7xCkpyKcxGOe0ZPpn4JR5TymCLycvCi?=
 =?us-ascii?Q?z4AeA6d512nj1Mn+GekW4/W3tn3YfY684BYTmh2dgJaVHXw/9jB5AqrLOzH6?=
 =?us-ascii?Q?yxSSGthgTMkzuRmOezpeR9h+nO0CFSYgOLjZS6iJygH/4bo7Qdcr55o8ayIT?=
 =?us-ascii?Q?Oqi5emZKQXbPZaM8t7wV7gWthSe8ihzjPwn1qsJ8KfWDSmsI85MJeHRPt9Y4?=
 =?us-ascii?Q?PdEyZljkjBxr0eqwlY/uOHhO1aS+H1ifJSfuDydesdDi30xeWl3PBWgXGqV7?=
 =?us-ascii?Q?IENBWtJbnfj4ABBgxvn/WeAnLcKTbHVM3KQoGFK9QGge5tAxChcl5ryCPJBI?=
 =?us-ascii?Q?gvSsqmMEmbpW/3v27MZI+4kB+3XM3svBt//8ycXlPxr/Irpi+0RGOBL+uuLg?=
 =?us-ascii?Q?kBCAfFzzBbiYn1ebmpDMZH32fvTnhFETMMDz5Hx19oj2lAQDFkp33ObNFPGS?=
 =?us-ascii?Q?euVzPkxNwRGqVZV/QlBXKvI0CVbCRTSs2qlkDDzllSrBQLjFwAOPavboteYn?=
 =?us-ascii?Q?Mx7hCA2nzI5W/AiKR755igbiGID9dy7vtZ/omEUe3r+WJKB+bHzXMAENbtpb?=
 =?us-ascii?Q?nV1IsB925/u/mTsoj4GDzQptq0uWs0u75ABEGG3967XGVnWvrczUW1Ec+rky?=
 =?us-ascii?Q?6juVGCDSy9PLCR8AzYttUezNPSjGMQ7StDpf2l5UYpm/D2KqVzD2FTq1NZhg?=
 =?us-ascii?Q?0dz1tQIgneNdyjj5YTJxnsNgWh3cY3AEspofAekJPhrpkxctDI9ivEam+Jlj?=
 =?us-ascii?Q?+6hGPcurYYdQEGPWzBapksqmCQDn085WAsCWKUmuB1Zp7kJfp83YfQMgWudT?=
 =?us-ascii?Q?JG04qP93Ire2fdlbc0YOP/HKqeDMTA4QEuodUwacbYnYcz8wjDj23+h7G7Nc?=
 =?us-ascii?Q?1rQPSb43isiCUlm7/gXiaMdI1xnUkwe3KabPkIS/CGAYQk1JV1bJqfUPD7rh?=
 =?us-ascii?Q?JU6FnI3+StIHcpXsSa0eZkIYMLqOBcmU0iIt0Y+kmQisxE1mb9Ot7rnUbZv7?=
x-ms-exchange-antispam-messagedata-1: eGnkSs0uJjzOJYQwI2NgTk9XRw9XuvChHiFqY7koAhWT464HUG2nL2Vo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c1ea74-1e9b-43bb-39cb-08da4929d61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 08:35:26.0473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xcd9lRGoOjkKA8OMB04OEgZe3CQRo/eRVL0yhHLVhJaE2YkCckqvH4F331oAdsMInwOgt+PHsNWozCeLSmihzZBXo0VVz2FwNt9dYJpG3ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7949
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.06.22 06:56, Damien Le Moal wrote:=0A=
> If a readahead) is issued to a sequential zone file with an offset=0A=
=0A=
Nit, stray )=0A=
=0A=
Otherwise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
