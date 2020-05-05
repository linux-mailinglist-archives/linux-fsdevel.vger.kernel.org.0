Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4271C4F7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 09:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgEEHqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 03:46:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13185 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgEEHqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 03:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588664806; x=1620200806;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sbx/u4ZTvzA0cK6Va53q3LNWpLrjLLXFzzh2z8Gu5tY=;
  b=g9cD6T0+O5jE433VwiGeSh6uqxZpE4bBY00GsO/8PsdjLhFncFCDktu8
   jzdwXt4QDX2dANj1mx7nmq3qISuMkmqOXfXcRTIzo7H7tEfdW5NVvUUux
   R4Zuea77eyvPsAGMqKkd/WYBPGkLFG9iXzuxpTzqIuNQ4e8ci7yqj0ft2
   hogPtGJ7LKKtd1qVclgyfLUCNqSsELaWwSH5UvGvhERD9FBZ/5bD1w1IF
   NIhrJGOmLQu28LBoL2c6ufdqQg1+Wa8SpihGGyvwS/QtCvcWBm/ZS8NXR
   1vMD3Gq0eXpjXgD3Pe7f9ScGIU4L0D9eI+enG04aY+9VTCwYklljCi0jK
   g==;
IronPort-SDR: YkC/YtCqJUvC6JaRWjQmRXrD/8ps8K1qb2wiyRNBuv6n4cKNKm7rqlnAopRy4H8CdmjX9HjivF
 g/550R50LHY3lePX1UgWbk2mCkhpZwZqAljfzK72PTVvnU1I15on8q3L0OCaO2gc9wzqNfqXMO
 ekrYTt7FDYGjcgwtq4bsQ+9Km4tMve52JDImVLvHgVqxz0q4oijx+SvZsGmvLnh6Qj94cVpY7E
 3iDFHxB9g306UAyzYVzUJddDDHae2lMyYCPzk4RuzU8Qfh5nNQcHDthDM9hqkepbck1NjA3T91
 lCo=
X-IronPort-AV: E=Sophos;i="5.73,354,1583164800"; 
   d="scan'208";a="141280215"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2020 15:46:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzDBCmHssiUfSet/ffbajxNfO9vcgG9oJQ54a7wVPpcZDED/pyqg1KJq/MS87a2M9xIqQOM6O6V6rX3trKBD5J356tDL22Y+udqLsofag5u5ulEvhZ5W1FNUuNXeGH3qrDq1j/1FpK67aT2KS43LTJiocwzQa5UN7xB8fkwniaoErwl7tIntGHL/YVs55Aa9V0x7qq0fWhIqREEk/O+wZOKV5mR1WaUoUsI9Ddo3KNYU7hvffg3qADb42G3I3xO4nnW8oXmypEOihBa8f96C71EkiD9tWrbFkwpq2u4m0LDipvT8BWwbHTqq+D8BHQ5HVLrQp0pah8UstKmaDFTaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbx/u4ZTvzA0cK6Va53q3LNWpLrjLLXFzzh2z8Gu5tY=;
 b=WLsXKLgJB/Rwg5Z76gTpw8rZ9K+NDgbhhkgdJjjB+aXL3/Q5RGS+P6xLozKK8hfExNKsl9AfArDsDT6VN/2vRBpQVVYjV1fVloPZEAlITQgIRE0Ik7oeIz9PXexPSq2K4vV9UIgfINVuy08EvFdusT5ALQIg2mr0y2rYouKbqbA091Khj9rK4MQmyGwCrLjaPD8Zd1elHSnHKda9nuWikryve+eloGGVt6CgN3JCNStdw03P650y/xZ7decVs0MRvJsb69fDYN5GSe+wqa5kh1Ub8K6mo3ggKrUgRNxVgFAIZB3w7EsoxKM+9V/6kp3a5Ev3aRkFH6SezCvp1r9hbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbx/u4ZTvzA0cK6Va53q3LNWpLrjLLXFzzh2z8Gu5tY=;
 b=Mbx3vqnEBStAh3wRRr4yco9xYXv+Hl5g3H6vHtnXLkrKi0cd3zOuZMCqq44wz5ZpgJA3JljhKXPYAwkaK6Kb2I4AP5hyvMcah0GQMJuI8/3A5nhj7fpLD6d0AtCzFO7dJ3TnUAvc0fFz2bdg04OChyhilDMWyXAc9nWvdhj+ZDA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3632.namprd04.prod.outlook.com
 (2603:10b6:803:46::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Tue, 5 May
 2020 07:46:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Tue, 5 May 2020
 07:46:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        david <david@sigma-star.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Thread-Topic: [PATCH v2 1/2] btrfs: add authentication support
Thread-Index: AQHWHUw3Fjk34p8J2kWvUrIfOj4HzQ==
Date:   Tue, 5 May 2020 07:46:42 +0000
Message-ID: <SN4PR0401MB359805375970F69ED7BDD5379BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <769963893.184242.1588628271082.JavaMail.zimbra@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nod.at; dkim=none (message not signed)
 header.d=none;nod.at; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 955afc94-947f-452a-1811-08d7f0c873e7
x-ms-traffictypediagnostic: SN4PR0401MB3632:
x-microsoft-antispam-prvs: <SN4PR0401MB36328B5131ADE86B7563D0749BA70@SN4PR0401MB3632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nqNA1tZohqInfEskprd43guG8QZSZLlI3+H0kdTOowykgzp1l4AfV2vYKE3/6A11DK1odBAfSvVIdmQhPcao0YbDb6bc7GH3FfGkFJQnJKpRfcKQ+8c5Cwqp35cM4cwwldwniD/JTa8TybTjp7hiovXvUBEZnPQlDMybTklYrvN0xke8X/xMUYFFw8w480uKyJJa2FXb3X5RZ6MFgwog6X8EMJlpECdDZFBrLPZoA1m427+UmSDCtWsgygysv7B2Z+RGfEXbBM6YDA0pDRtDtbHlaU7llmFZkT4Zl8EyRZ9OhE0AybRFbx6C0CoH1c8A/2SDZ9Kw4DYs5w9Nl6IVKNeAr8JggRX98VkTBHhorIGHmQif5HkXgg726DF/ZSCBtjjNtKhNlmqpS7/DNT9gfK5eSQd+txFzqj4S0Sw+sD+s2YPlrSVceTXk4BZAQO+xMw7GL4ThXvKN0W05oI2EEW2U4KTZ1lDk1X+ZpPr2nOCZbs0FbsFCLaLoeUHeXs0knlal9Fkae8QEfp15ilBgxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(33430700001)(86362001)(9686003)(5660300002)(54906003)(33656002)(316002)(4326008)(33440700001)(2906002)(6506007)(6916009)(478600001)(186003)(53546011)(26005)(66946007)(7696005)(66556008)(66446008)(76116006)(66476007)(64756008)(55016002)(8676002)(71200400001)(91956017)(52536014)(8936002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TWrD7pFvqrzFLgXu2TpYd1IowCoqasJkYKbqaoO3g8qPlTnr/jciDJqIxynaz8Wc8zJteEuSSCK/Q12M0irG31jKLUke4O2tf0LNmiwH6gV3gAE0laVBmYRcYWx442vTIPn2aCfANbEmcgx26WXVAllwBs0BWal5LJNoJpJLmvfCO0zVIVWPIXInUKUyLlsqnFoROWQ4tuO/GTOjYQuS5+Wk8WjPN36GojMEWcmhPWbLoqLMR4i6zq6+B9wGjMoetjfYgMsuMe3XgRtJv2XfqSREz0r+XoAGC4B9l6XwTW8PTROA3PLwY5xpHwGlwzVH/Afw7ltZcfBSZQWwSlj0CKT/SWxdrntOczi+o0Ue/cjq256NHQYk5MthWVVnFiZ/PiZ+myHZKYbUJqBDjViwyT1ERKzh7+CDLzCHmYO9uB9SbuCPe/sTHXF7j+El/xhgxcTXquIhVnSx6VChqQZScku77Ro4ttdl0erwxIZiFldmggNBG8qW6tUFgr336E8UGIUTPlv1/l1fKZnA2Rq0cEhqJoW+i92JGnAQIgIZllER0C6aXuitPG1Sd6IBi7ileLwT1TQIy8NmypI1VuC9uCXrOb5uSddT2BEbgnJ+pPyNWX87clXDtKwI2/dSrEq2VoDB6qfWYa+7BPZNcxs72JeWmJIVq1yU6WNbzm55U/4kKTP+rkPb/HOQ0CTQCB1shlPit8qLF4dzTZCnYhenC/ij+gWzTedi+85vJmNiKPn7bCWKjIxOjWjfL1tUKPuTkIkw/DVI8QZljshaa+M/OhWtICuG2sc51Bl5iJKcVJw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 955afc94-947f-452a-1811-08d7f0c873e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 07:46:42.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozWTS6Q/1bbiRlv0IwYAEJlbd26l3f3BeweqO+QKsbhWFV/gu2e/3GcsiJUvh7M78hQZfS5dPKqVDKpe6Z6HKCnqkYZATvyl59k8MRckRy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3632
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2020 23:41, Richard Weinberger wrote:=0A=
> Well, UBIFS stores auth_hash_name on disk but does not trust it.=0A=
> It is always required to provide auth_hash_name as mount parameter.=0A=
> At mount time it is compared to the stored name (among with other paramet=
ers)=0A=
> to detect misconfigurations.=0A=
=0A=
OK, thanks for the information.=0A=
=0A=
Will do so as well in v3=0A=
