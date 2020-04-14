Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0C41A7789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437723AbgDNJnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 05:43:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7220 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgDNJna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586857409; x=1618393409;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JjsN3/wDeOAyq1yPI6OtF5dwC+PNpCu8yaV+QrrPX/0=;
  b=efDzL6FOBrYfikYxdWiUvpq1o2waWC9sCwTD3HG+VhG88t7OLFeb1hGk
   9VSZmjCinlsDq033afYwlDhQDK8qzDq/fTXIEkheQaE/36N3b5e5yjjib
   tg8XrYAp6L0ZYqaPj5PH82K28rq02T990pnStglqccfEhHNxzgtZghjrR
   VvBrSrc4CSXGRZnYkxwpi70Uym/d8V9c37LcSLeojCfs2D/Sv427GM9cZ
   KD20zGOz7WKPD1AURwjsgXtctx+TqLP20JE89BwPDvAi5lBOMD9VTKmYj
   DYiH0OG7GdslKmENfXVavC+vx0b5HBjqP2A7/7jawXNDiwcKrCndR2ZYH
   Q==;
IronPort-SDR: rII4rSEb0I+aAp3NbKD1NOALIdPL81VhpsTpIscT0uGxg3uJECOfLxVlA+fIKwM0rPSex7Iq5T
 TcS4Mp58Z7XjMoM6zxYFF3k6A2LtfFwd0JxbnNmJsWnLPo6xUIBQoI0HOMGi+jWQWUdHV+OZRY
 WCG93bKkNlnVsCiG4wHEDA01uv7ZlKlJCnyVcZ8dM5wUrDXFoLZKgaJ87FL4iuPwKNfthAgsm2
 d1KhK34RzDXKkmryrRGqamRzuNyw6KpvI9PqKzzRK3A+/pn7LUycAFX0/lGJV6QkRLmfsW/OKA
 M/I=
X-IronPort-AV: E=Sophos;i="5.72,382,1580745600"; 
   d="scan'208";a="135291567"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 17:43:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1dFlYbODlH+crIheZmpZNOdFUQPpngTJtAhhfnjsdis19t11j8EwamJUepbfwvZGAjs1IvE5+e3IQx/1+qw3RxWK4eB8emVBZ4H8GBq6l7RaJJGUMTJIxWtiY2cVbsp07Cd9tXvvllh8dlLJqxUOK32aXzsBFnLLjdfyvFC+1wtYvdQoVvvPOi4vkfmufdiyxad5l4l99kq8VEYy/5xdIa0PI64gYgdQvoB3aXclylAKpaxHtyLz2bNfDB0lgl40z6xXLRPM36uhtJOFc4o9hdpVmes67MC8Qd0U7AX5FdsnF2zdzxkWu3JzSDS7QtnlXIErDYVGexxVK0XPurxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX2geM4plNo0WUYz3sfatTXLsFFeVjCMOZE/Z97rs2s=;
 b=lw56IkCjwN9Y3c1Kzx7/a+NCOdjwuRpF1P7Ob6g0dn7XoiEipojUjtBEBdJji5VL4XfNEm+LS8UYX2UP+V6RhWomqIVZn3gQV30GIrCBpECYXImYPStNBAxrPNBABwCvN/C/my4V1RfqYyhIDmZSe9Ko5agErxn6FV+i/bNBniihWWbqn1jgPv6JAAEd5etapcbI1ISaZKnRKvtGlBFIAnfe0APAEMX6jLc/N5Uudk1NHMx00zDE2IA7gBs80te5XkpgKeqep/KElogdEz+o1WHTbe1Vb3WeghzhZ2/uava6weV7thXifJa1ckbqJpz79NTr4RCmnxQHpqyOLpFJ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX2geM4plNo0WUYz3sfatTXLsFFeVjCMOZE/Z97rs2s=;
 b=VuUvP7+fy03vIpbYHmMmtaF0qU3ZJ8gs4boEKYXlojS77lSNxRtFAjTIMX2/liywCdanWTPAi/d0X/JdWRWMEC5cO/6hpIirdnFNiyucX1EqWPYPtLfwaJ8Y8+CYNrdu080JM9vsEpfwiBT5N3aXdTSZ6zGADcEtGap1pPBVZms=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 09:43:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 09:43:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] block: Introduce REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v5 02/10] block: Introduce REQ_OP_ZONE_APPEND
Thread-Index: AQHWDo95jboc2AavX0GtjTYeYQHkkg==
Date:   Tue, 14 Apr 2020 09:43:24 +0000
Message-ID: <SN4PR0401MB3598F69EFD255EAA28374D979BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-3-johannes.thumshirn@wdc.com>
 <20200410071045.GA13404@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf27e5f5-7462-4782-6110-08d7e058470c
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB367989E492CFC20772E28A459BDA0@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(76116006)(91956017)(6916009)(86362001)(8676002)(316002)(478600001)(26005)(81156014)(4326008)(53546011)(66556008)(71200400001)(64756008)(66446008)(8936002)(7696005)(66946007)(33656002)(54906003)(66476007)(9686003)(5660300002)(52536014)(186003)(6506007)(55016002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RQxn9A9+04HYlW9fvbAa5+DOPqyq5Kxep6G8OVTe7LDy7btwhQXLqaQ707NiJIhbKTY2B0Gky/L0Zrh1rHgy/ju4v5vYWLeSCFnowtAZgesvCnrMfGqZXFF60dZW5Ld8VpwfcWq3FDZAhdQLMIwuLYW0ZfrEjSuFVcWZjUr+D8nejVQo70C1kqlMzcuK3r8j98w5wyvBPNY7jmUAnZw1ytXCbOJmPsrFPMkz/ZPX6Xjm9gsLC8vLnkuHY7AyNFJxOSNpcH0q/L7+sDZd0XiSy4kOMyVccqkXXZLYmYCkDVQK7dYRJod35b3fjgpxn3pv7NHzs/KTNo7GcQpzHbhWtATf7ExciZAZEzV2JXIPYHamH4uHYqZEbfzU1yw6M7kC1hqX8NsZEsHjsMfaMo4m2Q91Xc9vyK+FJGr2FgRW80ABnuYQvgqFGXfzRJ2Lt8bs
x-ms-exchange-antispam-messagedata: mpfYElbOit1kzuDzp2K2wf32NGwrTcaO/o6ikPMgrPnCzWjeCM8Vo1wUlltWbW6IvDlg57xbUY3litWURBSyFukBXhdVVPJtFuFvAUL4hPz30rRz4Q3MlMPGwcmQejCIYhw/HidvtbotXd0EK2tngw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf27e5f5-7462-4782-6110-08d7e058470c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 09:43:24.8862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GgpQjTADOxybuxNyEmbmwxQfwmaZ6Rsf1A2x6yP1fUoj//Wf4Qq9sNt2hBafWHXUUB9x+S2Ls4k+J5IksUJqXj/qdfo2I4RamuHQLRaWHi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/04/2020 09:10, Christoph Hellwig wrote:=0A=
> -/**=0A=
> - *	__bio_add_pc_page	- attempt to add page to passthrough bio=0A=
> - *	@q: the target queue=0A=
> - *	@bio: destination bio=0A=
> - *	@page: page to add=0A=
> - *	@len: vec entry length=0A=
> - *	@offset: vec entry offset=0A=
> - *	@same_page: return if the merge happen inside the same page=0A=
> - *=0A=
> - *	Attempt to add a page to the bio_vec maplist. This can fail for a=0A=
> - *	number of reasons, such as the bio being full or target block device=
=0A=
> - *	limitations. The target block device must allow bio's up to PAGE_SIZE=
,=0A=
> - *	so it is always possible to add a single page to an empty bio.=0A=
> - *=0A=
> - *	This should only be used by passthrough bios.=0A=
> +/*=0A=
> + * Add a page to a bio while respecting the hardware max_sectors, max_se=
gment=0A=
> + * and gap limitations.=0A=
>    */=0A=
> -static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,=
=0A=
> +static int bio_add_hw_page(struct request_queue *q, struct bio *bio,=0A=
>   		struct page *page, unsigned int len, unsigned int offset,=0A=
> -		bool *same_page)=0A=
> +		unsigned int max_sectors, bool *same_page)=0A=
=0A=
Should I split that rename into a prep patch and if yes add you as the =0A=
author?=0A=
