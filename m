Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A1E1C6B1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgEFIKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 04:10:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1968 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgEFIKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 04:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588752643; x=1620288643;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zKIXd+zu6yRMlKQqd5iMusD0JflgLhD3VHLDfH2DNF0=;
  b=AX6ly7uud0Y5FdsnahE+qfTAx5b6UMNYcqkvhUoaVO9FfYafxD053Gyd
   0fBJEzvZos4nZFYvZW2M1B5ID5xaYNhfRiMh1AwlXgximFN8NNhfqwI0m
   nPcNCUZHkzCqkU1tOQvQ3o+RaAx4BOdHeUJjJWplH+fBLlX6LzCF0UpB0
   qGWmzdiKVZxL+j1oAJXto1sZo6iNd0Z+hhBadnajaccP4JA/2AVH/lTNc
   iUEiG0PBD0c2UPGITpRpo8WUglB1oJKKEoG5rMPTqMduMAZ+O6ffgBguS
   FnGhEnulMXEcYLn7dq1QLfWjfQN6B82pbkYI/Cm0EFIje1Ogb6h0Y1ajv
   w==;
IronPort-SDR: 0ZgE8IuOQFkqDzxmQb2cL7wdFgzgkniMwRw1we6ZV5urG0un8uO+0nmxNjStFD92ODxCYYydFK
 8PsG63rIXv39JVZNPX3oS9+JQ68G3xKFs8ub5FR8j0ayMA5/PBgmPROrZTNZ71hKLbn7yXigOj
 oEKXzQM3ID/W2nt06sTQkOSQ5mZH7OmuIZKY9ZKdT5MxaZ7VjoBSprT4uVA0yZP9yLOtw9MQ0b
 3P+ruvKSe5/1+NrkyeUCP/tUYerA+dOaKfiR4NeEnNd6Hs/hgHlqVIKkkJobs18AbXa5J2sNGH
 Yjc=
X-IronPort-AV: E=Sophos;i="5.73,358,1583164800"; 
   d="scan'208";a="141368619"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2020 16:10:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G16l7qqkWqR2Nu6GpARcFuXDZQYZ4JJ5dBfqQB5W7zGAGfJ1AtOj9e8dosLcSl+TkDTdnZtBIBu/jyFKd7JoD9irBMT3mDJW1EsYWqPHs2u2rd0KyqJ2IaK9pDyPmjiriCA1RwH/+sRGrgQYavm9j6iIGUb4WF6jjgZuAabGRkGIMCjjXrQx+rVJZjTfbE2GGSiUvehiohnVs57/eIedOwHD2QYMH4toJlQd4JcLzLw+/x8LIfQ5r13cmLtJ9V01xahT986bJ9qp9EvhIGjhG7V0WXgJKgSCZE37JcibJdp8owehcwanoGVeCsnTzR/INS0kWFKXyS+Wc1j2CHJsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73C7Pm+beHxnSi4yiljI1RQLSgvzUXj+SmEocMur+jY=;
 b=AsmLFFEXc1FC5TKF3GE8+VswQW1FIjdUBqKShL5Wwz9pFKXdvk3wF2sc+OGP5aYDPzqfkmKir/nsx45IY7PLRu/m1M67Iwo14NksIbrw7TTE29/NEZvxvRA7DqSCG7MzJR4dsXwZb7jeb5/cTbmAidXV/DYmUx6CPbyGSHI21x7AyeXdMvTmSogLKeg7h3QZWDAoktH8V7GfyKubXF/z+Ut/4Oue9sNjZJxKGKC9MeB5pHu5hz3LZQLLkpcbSVipwOPmsz4HdTFuldgabPsf50LgPw7DcjEjoz+00pBnkIjvgVvGID/UJDGiIgiIggbgrGbh//ERP3McsKFZ9Y9U2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73C7Pm+beHxnSi4yiljI1RQLSgvzUXj+SmEocMur+jY=;
 b=OgnkX56/ZzIoeLKlyutekVlyy2l0/XD9c0Z8yR5FUzRGiTAe1XgCoRjp+KJkUtNzBPJZgPHA6c9uD3Nvi+NRDuLSu1wExX5r5UZpmH4zV5DsvWptntPBCqb18RORKoNTdUqnOWET/8iLLQrywImKsy+DJHtpVFvBQK6MBlqPznI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3645.namprd04.prod.outlook.com
 (2603:10b6:803:45::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Wed, 6 May
 2020 08:10:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.027; Wed, 6 May 2020
 08:10:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Thread-Topic: [PATCH v2 1/2] btrfs: add authentication support
Thread-Index: AQHWHUw3Fjk34p8J2kWvUrIfOj4HzQ==
Date:   Wed, 6 May 2020 08:10:39 +0000
Message-ID: <SN4PR0401MB3598AC8CE5F1C6B60A5C75D29BA40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <20200501063043.GE1003@sol.localdomain>
 <SN4PR0401MB35988C0D697D9900C411F1C09BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200505223334.GZ18421@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e29f4d3c-abd7-4a10-e088-08d7f194f70e
x-ms-traffictypediagnostic: SN4PR0401MB3645:
x-microsoft-antispam-prvs: <SN4PR0401MB3645FACF385822E189AE0FBE9BA40@SN4PR0401MB3645.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L+s1b4Y2ne9+cB5PEnYPWmTKcCH/z8jCgcJQs65D0AOnQQBFHQ1A4ahfdmZWcYVP9xWvNa2yhnOfvP8FCChNsS+9EllP2ZzY/h9QwB9h7lJkArHfpMcvd8+wcVuL1HFQHVes2weIfQlrTfp4FO3FVP5oMvnZHSj/zJBKKyxatqACQKNwxfmbJPaVY7o6l3Y5Fr6Yq/SMnLtdflrhwRn1ySwsEpHRfw/rY7sBmvCPJf/9tZ5XIfI2j50JbOjlyan7GRK8xjG47Cln85/lN1QvdhznDmsF5jDe0vdAGFWzC8zRTC/XEZbD0THR3P2UXtHPXTAmiUggrq9oj6DXEcS3t2BBA36Qx492EAy3CsHNGuMST9xd7SIfC1avOxmyr5k9+mmfo8H1UHVlZqc8rFWs5uSBuSMkXElnbNxVF9am2UCs6ifXMu6Y0DgXRNL3lheJHv0StMHfB7SCqyoeTwMmJN2cKTfgvJEgCrWYvxA8GM1bxUYriEhIzx64LsM8l8ZQWjJHdYZ6NCl0g1ypGGfXVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(33430700001)(55016002)(6506007)(53546011)(33656002)(9686003)(316002)(6916009)(33440700001)(86362001)(54906003)(8676002)(2906002)(8936002)(4326008)(76116006)(91956017)(478600001)(7696005)(5660300002)(52536014)(26005)(186003)(66946007)(4744005)(66446008)(66476007)(66556008)(64756008)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: g9DyJ4Jfb5Mu8ZEPk9Qf82H4RgSjjyJm3pQxq6b1dC5Ayy9k3USFpnQUcGVsjsXEZ6a7LFrjuu3ifezLPrDxApej7r5lEiF27IZzsPZUjkvuzejVJKCOV37O81gXmFesLtHiL2EEXQN2EsmKf1Fdrt2EGczL8xjAMfHAAkwZy0resuf3j3loQ4It1TRczNJ/rakfaHGXuop0Er933tXVbhZ3KG4M9Oe8JC6w7dtZWh8vXfd3tXxax/eTg0rTtrEd/pv92uSDIa/NdJ1Gs7vRWW1XAcLH94MV0CsUgSnaWM+ZgZ3txBXM4uD7sqAcXNGqdkzcbvFS+6ydfTNPfn29eSrcT44DKi2W4fxIb/aDbWIEl2hNrfOrIEkLk5VYIF12pYCngS8wTFZK9DbkiHgpvanXvEwC9VcVtRyKyWsUW+XenJDQlPPLUruZc9hLIjTlIAYjVF5sP5KL8/Tv1hXaQA71LdjOjfVHz+Evuq1CTTpu/+uEWP4aauvCy3JfROEIXs4H+EyTkiGXyQEZImwoMQ0lg4WfX+BwXGS/KIkj1zj7aOXsis4hMJjW5QD2qxIt8qY0ug+7LZUB2KW+nulsnTuA5zNKkkDGhiZpp8X9u6/vmIHYExh9IeBcyeB0OFZy3TXqposgjITkX5QQ8neEQxhSAd0s7HK5ipMc+Rm9iuAXTZ7cXkxgNjC/AzS9dd0h8tmtB6I7NOrp6nMAZ4JT7lS/sXKDqCjM3MHD3Myvcn9CcRjqo8PI6CBwdCKNYDiv3f5JayForh88BgF7GUfXDK7MRCdlF7eXqCls5Z1dlQM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29f4d3c-abd7-4a10-e088-08d7f194f70e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 08:10:39.7496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wXy68EmbO+oSKphjR7SswJtf83v3fmP9k6+T2hRduKHeiDDPIxikU223ruM5i6P5YHK4QVVRirrd60oI7Fgk4my22PS1EiiW5/lj/A38ifA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3645
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/05/2020 00:34, David Sterba wrote:=0A=
> On Mon, May 04, 2020 at 08:38:36AM +0000, Johannes Thumshirn wrote:=0A=
>> On 01/05/2020 08:30, Eric Biggers wrote:=0A=
>>> btrfs also has an inode flag BTRFS_INODE_NODATASUM, which looks scary a=
s it=0A=
>>> results in the file being unauthenticated.  Presumably the authenticati=
on of the=0A=
>>> filesystem metadata is supposed to prevent this flag from being malicio=
usly=0A=
>>> cleared?  It might be a good idea to forbid this flag if the filesystem=
 is using=0A=
>>> the authentication feature.=0A=
>>=0A=
>> Yes indeed, authentication and nodatasum must be mutually exclusive.=0A=
> =0A=
> Which also means that nodatacow can't be used as it implies nodatasum.=0A=
> =0A=
=0A=
=0A=
Yep, did this already.=0A=
