Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEC83286124
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgJGOXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Oct 2020 10:23:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28394 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgJGOXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602080604; x=1633616604;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ys7dmpKo8atToHnXie6T/ghrEbyqR5fWyGKk2NBIZgY=;
  b=EdO93cfSMdWHf63eda91Bay2WSJcp+T5DbMHAAUQFCloXQ8TTbDnedH+
   gQh5wUCFTuhS5aMWcXvxDfcWx1Mzk2lW32VA63yxOJwPOzxSAh3CymSA8
   +iPe2vVHX1mbioXfYiHNJH+V34dqPFYi59XyOP+gqxLivRNryxjmnHHYc
   6Vq8OMgQdAUKKDZAWLwMrDeObuoiGEpq8veaEQAi0lU50xia/I/vifmiL
   oQmZRszW4TscaBGgImzbk5En0taJGnfSrH65XdJ7/ODzvHs/TDk6gLbPI
   31GZ+MTefeRxytQgjgE6ZwL2Z3j2p5hs+mKpQUwTIo54H0lWs4oGZNgU7
   A==;
IronPort-SDR: BXfxUp+BjWlP+cydOb8hmT4Edqm3TkMj3hU92CZVZsmYTmYw+0PMGYWDVIvc9kT59tb7U3IUtj
 5tIE4ldgtWH1voSSR7mC70ciaL+9nkX7miW3PvtZVN1uGZkSoCC0rhhDd77yc0o7+iOv9UgQvG
 9DNKHlG3V1qPFyn39jkSs64Lk5XtomW53qasMQHk5Et60dTymBqBJmpzaUf4C59EB6gX7/GqXG
 GzZlNkEIsAZncmO09cGxnWVhai1kPOhLqFlNlU9YgK+9EWCcR6fWlzo2NQ5T/qzZH6DFUodu1Y
 sLM=
X-IronPort-AV: E=Sophos;i="5.77,347,1596470400"; 
   d="scan'208";a="153689723"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 22:23:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA5GBzNeYQRjQszqt35T0j3tV/VSNvvW6c41qvBbZNkcPt33kMdKllYzzyNFvFCXzQ6ebVQiXeHHOKeJTo4ff8z1AIbTcu1iem/MfA47KZdjPMDO9cmkaD2S8v/rMWCL1ekHVsgSARS2Epct7XfgfoYcu+hFU2+brOQMjS9T6rgMqS//fG6RpF8mBgpC+AHhKU+EODBcxoAuD3y1nycfPYT5haYDA9AF6ECcnhhhvov+vldjbhqp5ZCeSjxuK0uizFNhtDeHg0BL8WCBtuY5s7aOe0WKWDoWJZWOiTDDdY1LFsgzx+NpE16poNnnFiXHUZ8N1wj3r3VK3z7cJqccGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys7dmpKo8atToHnXie6T/ghrEbyqR5fWyGKk2NBIZgY=;
 b=EEHOEOs1/9VFlxgiFTwvHTq5Zpc6pqXXwBglITDsxR95c3pHRPE9c6/vpF/mHNzYKhIIgCn68EL99cFNfIdfOdzOUx5dae+fzilEGgn2VVvqTXca/GnYj0eagUB07m+fGyil4uLZo0Dd0PTRGY2XY1EUoKvA6gZpteaIYsQw1HYZZYEl2lU0qfglrRKxzRUOQccEp7aDZg+77Takd1LaIQeDQrGNleECCviBvco5Gg+j4jBjYHUy2OWE2/9kQNJy3ebCeJ7FLeUmiBWY3A+Ql95/21sBmXUwwY1Rb8pk324ov8tUyqJNwlkxl5wTSPB3ck/Z4lJRJaZkIfv645aobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys7dmpKo8atToHnXie6T/ghrEbyqR5fWyGKk2NBIZgY=;
 b=GIBXjMXE1+kBC1EgVZ+V+7oMjTVI/HEVT/HrOSk8ZcFLkbwdt2tzsjC9y4sbHeyhP5yB206drVG31RVUtWZY+Qy5/xoVcoBrv12AxWpdIX5DwB/MMvKBpyPMT0KogKVdcgs2Cq8rxp9vzVJhzZtB7kx+PreVRskVA/bEJ9WNc98=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3518.namprd04.prod.outlook.com
 (2603:10b6:803:4f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.42; Wed, 7 Oct
 2020 14:23:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 14:23:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] block: soft limit zone-append sectors as well
Thread-Topic: [PATCH v2] block: soft limit zone-append sectors as well
Thread-Index: AQHWnKZQvxzyHNeQPU2VKJ6raaV+0w==
Date:   Wed, 7 Oct 2020 14:23:22 +0000
Message-ID: <SN4PR0401MB3598DA74A400D6299B0D4BB19B0A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <628d87042f902553d0f27028801f857393ae225b.1602074038.git.johannes.thumshirn@wdc.com>
 <1aa6105c-423a-7400-a3a2-d0c701bec09f@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:d469:2a91:d2e8:8338]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8369211-f456-4116-76a4-08d86acc8bd0
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB351811C3AB49B95EE7BDBCF19B0A0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: INi6ydo2BJjht+JFciXnV6RBhPtMqrhGvuZKUaQLdrIrMjJ45KIdu9iExf95Gb/nKYrllhCiBRt9gSTQpiJQqvGMgP4uFq/wDqYwdpFPP1e9R2RfxemPypwJZ6SH1aTJYDpkJGDPXasBQvvjNTZwaEcMEVF1Gq7KwkukZTqng7XLzMWqR+xvC4l0WU8goA5ImaX2LiCz5yluQBj8LsQ/gN/t1qC6F4IIrIYOCyMGqzmoaMFESlKdC0KhWIurku9zAQG5LMszYpCK0NTEbU0JRd+9fF6flX52mjYesUSttJNNA9k3wgSUyCHdaGHSJh81gHJAIsmZLyB/n+FDfihplw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(64756008)(66446008)(6506007)(33656002)(55016002)(83380400001)(91956017)(76116006)(186003)(66556008)(53546011)(2906002)(52536014)(7696005)(4744005)(66946007)(5660300002)(66476007)(8936002)(316002)(54906003)(4326008)(6916009)(8676002)(71200400001)(9686003)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: a5HM5nIRWhm5ZpZt02Bv6kz56ZcsQOhn5J68BMs6DmWFmkUr5yj5IJ5crp4exBvInc4QBAZdh5lFlKqZ1nuPHzUl4gEv5If7Xav9PPJ7vnlKA6y5odSpPukyTFI+5fugdrmHFBbI9c2qvZq6lBpCtxY3/QijWikcZ+qgJPbAmpDSU9GJ/3R7wPpuQ5L4u+M6BkwCS7JaJXHoB/8c/W3QksbvBUwqT+8W/mWOdyxSC4dnvMzbmJkb9+tCBl+Ew7e2sVCrxmRz4baC4iOXReIHIvH+cSMQLZJVPJRs5DrTOmofzTQ9qN6vPfdwnG+PLGS2ujlwFGE29YfA0bspcAtvBMVbxkGmlag+w6kT5BNvQq5XXPZTL0RSCFyqZ6e8MrJtvJDVHAJDYZbRNZ1PXrvifdECK7cfPFduc7pjIJ2VKlK+rSZKhoTw8GiOUYvaC/y6XOdCTHgQMfmgzegTQ8D2Hy8atEp7uBMr2wikFUvKFb43193W1yV9VkUCfbJOPatEzI1827yByBX6memoWzfjGpQ1tJZE+8iqx8yk3UuK1okhEam0HgpfPpR3fv7Ls05pdGMNnitkAZFYhHDWwyxqI5qtgcwKXdslOmrw3Kq0N6bKbe/7EwefUBC1NAtUoKjCHLLdRZU+47B5Yq3CN9ZyKGqzEFd/bHDEzwdg9XVRtJaiBWjl7xgmV0/E+wLI6REO8Afv6AA44Iigfytb295lTw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8369211-f456-4116-76a4-08d86acc8bd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 14:23:22.3143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kvGLhcuwvb4tB9PbijwBgkACYanioRu2wIYHeIlfjPOXk4WPoyPNiGSvUGhej5Kb6wZWmTvC5uk3W/5o+M8eV/UJrBiwDHTjLGdvCQLSqSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/10/2020 16:22, Jens Axboe wrote:=0A=
> On 10/7/20 6:35 AM, Johannes Thumshirn wrote:=0A=
>> Martin rightfully noted that for normal filesystem IO we have soft limit=
s=0A=
>> in place, to prevent them from getting too big and not lead to=0A=
>> unpredictable latencies. For zone append we only have the hardware limit=
=0A=
>> in place.=0A=
>>=0A=
>> Cap the max sectors we submit via zone-append to the maximal number of=
=0A=
>> sectors if the second limit is lower.=0A=
> =0A=
> Applied, thanks.=0A=
> =0A=
=0A=
Thanks :)=0A=
