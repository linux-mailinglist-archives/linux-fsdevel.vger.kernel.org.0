Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB42A1A4328
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 09:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgDJHqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 03:46:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30321 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDJHqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586504769; x=1618040769;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dZQhcacGwMzOWD605Bx6kYNDh3/zLHzyvmtwjZsxmEA=;
  b=SRjP3OC/udRd9QcWuDD2Ee2x0VX3ndj2AiIrXkr6WadaUxpE6VPXnHGC
   84+MTA74f1Tz7ql4LrzLWvFJlcfXT6WL2Q5mHkGB67rKZTPVWhq7uXIAu
   ESHpt/3SFUXkD6ACOwadMbrDIJbTOy/aCqNHi+f6cz9jH8LqqPAzmsH7d
   45q0sCGRIjK9CJxeXda0jxNMPJZrE6I9eYsdWN2WGqlNoYntxhpZOozer
   pNrT1O11UwFdadBDlfpiAXeTHfY8cJrBFvOXklHy7ZOGTDq5fczLMkBL+
   JVuQC3vjgeuHKB5zEumSaE+5vclnVWXwJzsJ3qKynK5hbNeNkHT8B5Auk
   A==;
IronPort-SDR: pwEJLjuZ1JabbKkVgi3FLTiPTrpm8Xr/jnb7iHgXgL9gHZK/Y1doEfi00Drja9r6E6NS+lD8iY
 7xilqr6e3WFfj1NUCe6VEx7DfZjQ3WKlPJYbrQ0ISwQBtluOLEBSxZAaFeNrD+m06RQBx+JkkE
 IWIKvt3WSeSdq3bRG/QkESAoodgrzhR+lLfOuK8otQ7Xpjmb+3Gw6wSmSRHUrbezCYoPOAI0RR
 LO8o+DwT7T6phhtu4uguWUYjM4Mnobin9sEJiJytYG5YBPxLvDK9uReoklUBDmewqjR9PmWIOT
 0W8=
X-IronPort-AV: E=Sophos;i="5.72,366,1580745600"; 
   d="scan'208";a="135349005"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 15:46:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jolfeZpFERTmKUUkU7zjhmudlYPY/y/VpTPUt5ob2rj+o57CFkX32vwe1K2H4nmmbzOTb8TA9UH/gn7QwUT2ew0N0h/6nR3kcFl6KinNMDy2V/1B8KnuVJ6SB9/tKW2VK0XGvO9Uuv/72LmqzmqXuz/nXGaAjEObF4q59j0wXiRdGQQXzlzJYPO5YAJ5rEJdt1i75Z6qXW9nSmqqejP+0uRmQjMyAZlm3sMX4WoZTGzCZEVXsGTTQ3IxTHiqZtIH+qXrJKtS4/JJVpxFRFYFyTWYqK9NpD9Z3XuY8r4+017EtH9/YgeR3iz4zz5Srrem5ERU/r9AhfiLILDOzDSXJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZQhcacGwMzOWD605Bx6kYNDh3/zLHzyvmtwjZsxmEA=;
 b=IQz/HxKvX4ID+VoNIf5owgzj0I7XsjkMTQbzqAeXpWZG6iAE7Q2AkIjq9tmP6XvsevdgtJk84n3UF5+eAEyLAaCd1UqxPsxl0+77vqIn8g18cSNv3EWnr33hQmYsn6Igtn1LzUyeIXrRgh8hXiEhqqBtNux6GBCdfoSmmtR0JGoY21toSt90cot9fmrJJNal0FomneWOvB9tr2o91oKwTlJuWZyDaEugtDiWQ2uoDOTBVKBm03i+ufJGBR/MV+vQHtQC/1DfpA+IJ2Cj9ppytnEjdGWKZmP2uT1dkXYP3ITxblxdZP95uB0InG+xwEQC2BQT3CgA6NJxjEOu5RRcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZQhcacGwMzOWD605Bx6kYNDh3/zLHzyvmtwjZsxmEA=;
 b=lvKQ2BxKE4uQ6j2UpS2c7vRI7ZpXBuEPKA5XOFHsqZ50Ofg2lGISaX25IGqO9ham7YG4/vQSvuIVHCZVBxV/AP2b3LbJnCneVbEYbruoJEbyDzvOV5IFP2wLuR+5DUkqwKmRtGv5NSqdWkNZiVfnlqzLIy8s6eXDbG2lYpS6ghg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Fri, 10 Apr
 2020 07:46:06 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Fri, 10 Apr 2020
 07:46:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 06/10] scsi: export scsi_mq_free_sgtables
Thread-Topic: [PATCH v5 06/10] scsi: export scsi_mq_free_sgtables
Thread-Index: AQHWDo99gjY+dyj3x0GZvCC3NTR+YA==
Date:   Fri, 10 Apr 2020 07:46:05 +0000
Message-ID: <SN4PR0401MB35983474DAAD4C0A988AD9E09BDE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-7-johannes.thumshirn@wdc.com>
 <20200410055834.GA4791@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f519bc8-12ac-4c21-9176-08d7dd23399a
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB366270C4691E8FA639295A8F9BDE0@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(66476007)(66556008)(64756008)(66946007)(33656002)(76116006)(316002)(81156014)(91956017)(6506007)(66446008)(5660300002)(6916009)(8676002)(54906003)(8936002)(53546011)(4326008)(26005)(478600001)(2906002)(186003)(558084003)(9686003)(86362001)(55016002)(71200400001)(52536014)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gf+CqdMwrhezq0+XyGXdkKztdZk9ESsHIAjiSrhG2Anb7+kYlCIqv01sEWd1WRhM5jzVDafWxRlyN3AuFdfZTi5ghVBbF09Yv4hcknVNeh3LI25O6ycaleaOuj5cOIHJgGbbedWae8co0QxNJMkJbwncme6Xbt4x+V6HkwKmI4dNXg30zNViJk8Twdaq+f/o2F5mScP5LhITZj3pZuqnwCWLQWaxoDppGhWnYfLsnkX2b55NU6umVcMos+LLTNCuFD4VeFRA4ZRAnzot3PgvGbim9Pwjxqxw+6LU4qBRtoqEG99752TjNiPuXdq7xsdi+Ie38Awifzkq/fHZF2CgE/wja6IfGGV2LfOH4VxydEH3ja+Nd6CWQ9Trz78YlPtcMnS0xyiEd/LnohP5XUk6cCzmkR1AhB6Gv9VhJEAbqSLnFoBfn65CqzMcqh7126BR
x-ms-exchange-antispam-messagedata: QqdGCn4bQQtSLHQgiI2982d+BP+BFvZnTO+Cut2qPArJQxw/bchOx7hPabCS5zOrfcJztTdiuRr1vfV/9CialiwKHVpJgkT1/vvq0TMBEfHBsP/kq7xWc0ehubyUeWQvZyhx4eEzK3fLg4b/ArUZCw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f519bc8-12ac-4c21-9176-08d7dd23399a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 07:46:05.5150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deHcrvpaNn3GHKpe3C2Lc4252pQ14Q7i6zJb/kWAkj+astnCOihlRRyTPu8/aLXyNGm6A/sIgduqpQwuuEk9oxGWbyekucnLrSHFqSltwQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/04/2020 07:58, Christoph Hellwig wrote:=0A=
> Looks good, althrough we really don't need the extern for the=0A=
> prototype in the header (that also applies to a few other patches in=0A=
> the series):=0A=
=0A=
I know but all prototypes have an 'extern' prefix so I did to match the =0A=
style of the file.=0A=
