Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6FD5A9403
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 12:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbiIAKOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 06:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiIAKOT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:14:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47780131DD7;
        Thu,  1 Sep 2022 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662027257; x=1693563257;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ljfSWqUf/qfVIsFKNoLSYLOUO1yGn6wo9opWKL+lJ2eFHaGUCzZexfgc
   1s8mN3L1i2TvEMtW2VcBabBYApamXz7rBjpL5lQBAgzAkMydzhcmg2Nsx
   r4ez7T6RzW1PtClPKr5+m1AVqzAKIXFGOD+nWhL8ta646MxMyMDH/on2P
   BTaKrV96ADJEpVF6ZPV++f+ufAT8QWjfLJXYIgNmnkBIc6UL6p41poBPh
   3cWRuQE3wLc5EQ97E3UsNf36GxklD8BYj7FauLyJk5q4cX9iyEzj2dZ2u
   26HBdf5xFHDOg7DXHmeobZsNdcBeBghvBAxNviUHAC0S38IjAEFZdhWBx
   g==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="215382403"
Received: from mail-dm6nam04lp2049.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 18:14:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX8sHKpaZxG38JZDQ0WWFoooe0WR2K8nploj09bVZoiRyJlVyI85/CbHAbvMoMbVIjVROy9cI1qeWAiK6/iU5mJ2vEkqId2PxDrI6Whw0TQ3tNybW/zntzAMP9B53liu+YXUeIECSDYG5D/a/YSe+7+TnCQ4zJj18kBFxyOFmYlmrJmQ73bHsRU3wtQLAg57UttDAZj+VNS0giBcYXXZ21KThI7CVCkR+89q0Z2nF09hecXq1Ydjt+iSp/Bc/GdYfujhMpyRIay5fbS8JfG1DLmiZVo6zCOfTifnrWxZQ8yCGdlu3GF3/MPAWnELBZWZ/H5OVuWCcGTP5wp3mQuiCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VybbQ+TCxzFm/WFvZsz+x54cnAdLsZ+KqpjpO+LlgPxOE78yC1iZVOHkKfnneqtMU+7Te5HdSY9axPhQQsBAPPB4kd/N0CXc7e3JAyn43hnzRPzN23EYNAYsvUkMmVlE/Y+HHT1yZkqV28QX+Tv9vze6oc9dMPhS6bO/Xgz1ceE/XX347cMY7pgJ6qqLmHT56TndrSscwWPsKdl08346MrwukWHVkWuD+14COMx0CbD93njxI2oR3REJVQ10mjsgFStobM3YnQQHIyjgmzhe5+cLJaCa16RcJSihSEYBhw3q92SpMDAoj9WThVu6t1fWJXLEpAzW6id51jCO5iHwZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fV+uXKoRYY3eaPHnydEROJP1HP5oha+WWAcDanuye9jgLdq6jG41mc9/m98gQF5X2aJExKG5sIX5Ch5qphJ0VVB0lYoVnLpm/k+v00WiwSx1g6SaIRzwI1B+Q9zGNvk696dFXBTfWc9coHOH/6klh2l9GVtOXgt5edNfIQGhmf4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8100.namprd04.prod.outlook.com (2603:10b6:610:f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 10:14:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%7]) with mapi id 15.20.5566.023; Thu, 1 Sep 2022
 10:14:15 +0000
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
Subject: Re: [PATCH 14/17] btrfs: remove now spurious bio submission helpers
Thread-Topic: [PATCH 14/17] btrfs: remove now spurious bio submission helpers
Thread-Index: AQHYvdaDvdiLFq+IF0Cfhre8o0IkVQ==
Date:   Thu, 1 Sep 2022 10:14:15 +0000
Message-ID: <PH0PR04MB741674E8446DD3C6F1900F529B7B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fd9700a-9b23-4c99-ab18-08da8c02b97e
x-ms-traffictypediagnostic: CH0PR04MB8100:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hSWSsNey9BNTxJFif1zRgzlpiGcW7jg5o8dz2fhmbejzC9B5UXUGhDnILSL6qFIOTJIx2Ye7Wvy48syxlDTZ8zNkbp2cWCIt2ekJOqqP9JrZVHetExbWmXkzg3HDrGA7bKTauXa3iC2kD0ToHPG8Ye4r53H2jg50xfP7lYnAg7YIGPKaJLSZD+wck/2s4HBuxixvXoMu3OmtkCt42egwz2SsnfKCo/9zAChJCD8zRH5PKx7EFkUN23hdoLrYWMKZQjmyJJ1gBjJWqGsOXEkLqSNEi+lvku+uC267vIbo+zJzuhBzBteIeYPRgEPB3SpOBfJo0rhMYugjgeye6GaByCEjYPa8ZO0Rgd+ow1u24Ds1AWD8dHSWeOZkSjYcWvjMSr1AJ8YLL0MvRDCGFzXQLAYRO7fateuK2U5DDDjgkhQo27wSEayNqvvnw8PQLQl3Unof/ui6EM96lTbSBpOo8uvJqBY//nnqI9EVrS4wpwk2Pmcrxr9zxFC4sM+EN3xjQcRYgYGgxd+H3t+JWAX1fy9JpR9AWB3M3Sz+KYd474oYPZfUrMzWQZAYjfWIk1yZfTAAorx9k7IDCvuQ7eLConv8J12i0+tZhLQ8mNPSZ3pHJ8umW5NLcU/Yxi7Nc3SciruNt2KrX6//p9yFga8IRxB0sm3VVMwd0fRzTR012hSbsN4Y1HZEiMUnyv/5+k6Xxs4xHzsBrgqwjEUejp2hBQYNf9kDGk/gqCR3MAKY2fBKinKQmHQyLXxyAfviH8MnD38NLQ7TZT1rE9HZsBFFQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(19618925003)(186003)(4326008)(91956017)(7416002)(52536014)(7696005)(2906002)(8936002)(66946007)(66446008)(66476007)(8676002)(76116006)(5660300002)(64756008)(66556008)(6506007)(26005)(9686003)(33656002)(558084003)(478600001)(41300700001)(55016003)(71200400001)(4270600006)(86362001)(38070700005)(82960400001)(110136005)(316002)(54906003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lxbK9g9CgqbZEEBN52pa4CRW8MtJfzWK2Vvb4340OBRuPN2mVgDddGSkszSf?=
 =?us-ascii?Q?cSMhhfi9vegFdjx0Zvs2tf4ZCX8ZSS62KhtUH/9fk44rwNsEFPp+c48LR2In?=
 =?us-ascii?Q?tSfMJFKCwVeJJEJkB8AjjD/yFTYkr9VwzM4bH7FTg4pSZIdzaP4HxNM7JvqT?=
 =?us-ascii?Q?Rp7nB8xD453/JPV+XoLgJq0rwesGt3XvSEhSCemUs9mCvLx//e0pPi0kY80D?=
 =?us-ascii?Q?LRmrJ2BINefn4BIzfKzOK60brbar8eeJ7EDmo8ZcNcoLTCARZjMmUOE5BxSF?=
 =?us-ascii?Q?t4OEwEforgt/byahF1cerNf3IqBz6Wk4CfuIf/+HkVO5KfQozMA2ovMkfxSd?=
 =?us-ascii?Q?Yh3iB5/HS7Cz8gyiCRLETEeI0f6XHuhG6b34B1t7CXBHeuG6l7N//gGImxgw?=
 =?us-ascii?Q?VBzGfkT9swfXalbuHx7z/bIyXRnkDUNPaajJ8JR7L+epzIaiqKFgJA3K4Pow?=
 =?us-ascii?Q?F1TJGD3DTYYPAtEYs50nnKGf7WM+MV2phY0drXdfWeBsJ012aR2od9oufj4K?=
 =?us-ascii?Q?mfqHds8kOfQzU0td/8HIr0ofZVteHrceRQbixMbk4h2FEyIPfsV6o8mj5JgB?=
 =?us-ascii?Q?3Uybr6mCKtLAkg2mEyKEt7DOTB1kJEumVZFB8lx5XIeTFQUvC/uYRhJcqxfY?=
 =?us-ascii?Q?ROdrpAAkkPtqN8imW97kB1EGYcMSg35MeLCxQR7+QgirGv8/pV9Is45/Cc4V?=
 =?us-ascii?Q?GqxLkeVikjObnTSI+aGXhek3lEm00iDPV0rfqS8Ah3OyqyiYIVHDcqd9li75?=
 =?us-ascii?Q?O9yNQGqNSQXKGcPFYDt8pBWaGOeOC8pAqhSeAxSpZyofLeLN6pUFm4hvYzP+?=
 =?us-ascii?Q?7BiCND++OHjT8LPy8zzis4HROIy6N2c0rEHjJUyJG6e8g7XfVsGRpzy6yFC9?=
 =?us-ascii?Q?gjwfbQW2ZAJv60WUCZGAqlZKbbKcyo2wwzLPiYQcoITd5ZVFTe2SDVY9n22E?=
 =?us-ascii?Q?Vkw3jA4tl9QsOXHrAX8zZz4R5bPckNM94zz8pf6q8gFBYWtHq5ufY+GmHPmy?=
 =?us-ascii?Q?km4Rd//7VNU1zih+J2nfqN2A4YhyxjUg1fqFaiJwWxLGczkNaCAjbWWZ5fCM?=
 =?us-ascii?Q?1ZfAGx5Un6vAJorKNCc8bLEtOJGvPrvOPFs5rbMPGIJqZmcfoklxBjnm2Lfd?=
 =?us-ascii?Q?Fz/UvDpTbXU3NqHVMMj82rzDX1ptTNTGuXA4WaMgzx2kjWpSdxGQfRDd8UrW?=
 =?us-ascii?Q?y+8phEAHFaQDZnlnOqRofGpKMNI/O0TYCJtXgOaoPmL0D5QDGwOquiosFpVV?=
 =?us-ascii?Q?gNTHk4enp+rQlER+3fiSlcrfDQjDERotHt9w5mmtlRP/q7Wcd7wq+fSUcIVP?=
 =?us-ascii?Q?JE/gFDMwvgIm1xUznbDEkgqb4YQovVB9Uz3RzfFWQcbxVtE4OuyUrGg4we32?=
 =?us-ascii?Q?ZenClXk7DSRpH3XjYNMpqCeqCKr2R/QqwP7z1+szyy6J2F2I6Ix/i6rLiB4U?=
 =?us-ascii?Q?OS5KvxEkm8MYBOoFi/Yv9HNJ0tW1BwH3Pnad7DdVEIeb51dJDF1KA8pOW5NQ?=
 =?us-ascii?Q?aphLkP9wfm8R5JEBYEDBPJkuvIZW2YGwF3YMGbaD0wf/vgpqLtDz6C2OiX5q?=
 =?us-ascii?Q?wmnMEvkXUlNbrBqGksXhWyB++W3f6PoTe3Ln3n60ltB4XqluMAqdBuyGWXWI?=
 =?us-ascii?Q?W8k4V+BfB1DcJVIsD5Gg75g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd9700a-9b23-4c99-ab18-08da8c02b97e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 10:14:15.5943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zlnc0o+yOL3/cLTFEfFSgh16BS9FsBEzrnOBl6f7DlvPwY6mLhVoMM6F7ruaU4s0PCNcmJr0LzFNmyzCYqEYPllklzvwPX2EJqR37i3+LkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8100
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
