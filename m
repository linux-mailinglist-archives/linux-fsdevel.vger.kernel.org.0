Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270D31BDAEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 13:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgD2LqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 07:46:07 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:45262 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2LqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588160766; x=1619696766;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SkIkghjhRRSErCnho6itVzRfz6pdLoPg4kTXbTPMgEU=;
  b=XFVk9pWUnnG8bZbwxGJWeN4KHnLii1pUdNCjtXZYYd7FFhvfRXpaLb6B
   obERs2sH5YLIbaOEubJnBHOkZOMLIALQ693wuehKtcrAbPB0eRFoa6WVl
   pApUQb7JSkIHgpTD2/r0ljVn4H/SsE3FRHRvJaJPdzd1z2urxiaNVappd
   7FZm94+YMiO83FKgLBj5v8316wlqjN0knokjhoUiOLssRNzLnwtzbzPJq
   vpbWAVUnF5FqYvQtWyc2+bU3Xro+JrwSDcGm6Id4+iZxENM4Fj1TzKVjK
   /n5Or1sfBSSPFj3ZVhzTpFjZWbSm0VDZPZb/gPhw2vW1+qLzKVXFw+rSH
   g==;
IronPort-SDR: ImMwrRw9iuWl9oddiyDPoRGeV+Pdf0lSFcyRgA5R+3Ux+O2FqINuazA4g0vJElxagBaElW3pLr
 3eomqCyTUziBHvFFv/DQpxpt4HCgdifUpmg+fGhqabD/d6lB4MqrU8EDkqyLCFj4X1q3LdcItB
 5WnvWlp5y36tZx9I/lx5iUlb4djM5YpnTMA4jxxRCxTloNQSZhe5/CCFHUTyJJ7l8lX6q04LIk
 G8W++tfdX63cWVV2DrmUqvw5h9DDZPWATG8v81GhYTLB01rclOPor0sqSHCL1NRn0nDqWlftKi
 Zdg=
X-IronPort-AV: E=Sophos;i="5.73,331,1583164800"; 
   d="scan'208";a="137898041"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2020 19:46:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIt8znwUTIkszlfWX+1J7dcJufgTrhIpDco1DTO5v7yxxWe8MJDx+zDh9JoNBIaPLwhyid1RPxnemuYR8gWp9cHtgEljBqh1T5EPaInotlQPyDnDyz/vLE6BSgITeeyQS8B6FGSRaHxlThKfkB1dqxLMUMej85Xdj0+k1iNSGzFR3Pnmc15kyVWURsuvSCCS5Mk7IyR+YfcTtEpXWFquwBn2Y2BqkhKYb/DD77a8xRHLRB0czDObshKBtvpYOaUEAIyKofYytADNcNxIHOrhmmeFWK2TVB6nSxk3cbTjKbzzxNaX5htFFZ8bY6o6maJUx4BD3svuW11FHsuHEdeoTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkIkghjhRRSErCnho6itVzRfz6pdLoPg4kTXbTPMgEU=;
 b=Tq2/IvH2KxtCmQGUkhezBTpWX7v4VwEjN6mXg7jgc0IswKHiMIcJGuNFJDnhugOmW7HYZnPUsHhTL4isl6Lfw0QQLLDX/V8Dq51utcBhdhCUFyUvDb8XdoePS3l8WBrhNWji+aMgQgu4EnCgTT272nGgWIYymaSE5va7uVQzH658NWkuEqo7GUXNC0N6MeO5T8mBGRcJ7ib8H3J1KhpXHx0dKT3Qsz8K3QboZGtM7cYQkR0ulKwOHvXN7wr2ye+MeALrZ5Z5z+hMG/tg9KA1SSBdXGYRZOGZKmKY8919bO4pgmlNbfbXl2riyCIByp/1T7zvQp1moaH1XijwMIsa/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkIkghjhRRSErCnho6itVzRfz6pdLoPg4kTXbTPMgEU=;
 b=h6dww22SrF2JGEGKQhGdr5j1P1Bbk4cvnLTNIGcXoUBG7zahEaujVNljkzyGCwygK71XTm7MmotsbCo8oJmSIWvSFnZhoDyFfDtUgsdT4HsBizh81QLoWTwWELBrGmO28Iz0618ZoDr5S3lq3+pgPkgYTGV71pzi5cpqe6JRFvs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3710.namprd04.prod.outlook.com
 (2603:10b6:803:43::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 11:46:02 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 11:46:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Johannes Thumshirn <jth@kernel.org>, David Sterba <dsterba@suse.cz>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Thread-Topic: [PATCH v2 1/2] btrfs: add authentication support
Thread-Index: AQHWHUw3Fjk34p8J2kWvUrIfOj4HzQ==
Date:   Wed, 29 Apr 2020 11:46:02 +0000
Message-ID: <SN4PR0401MB35989505EEFFFA6BE46823029BAD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cef73b8f-6e12-4a1b-43e1-08d7ec32e4f3
x-ms-traffictypediagnostic: SN4PR0401MB3710:
x-microsoft-antispam-prvs: <SN4PR0401MB37109FD20CE13B7F93CB55BB9BAD0@SN4PR0401MB3710.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(9686003)(4270600006)(478600001)(110136005)(55016002)(316002)(54906003)(7696005)(5660300002)(52536014)(64756008)(66556008)(76116006)(558084003)(91956017)(66446008)(8676002)(4326008)(66946007)(71200400001)(6506007)(2906002)(8936002)(86362001)(66476007)(33656002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: esmwrDm64uFI2JABeNPChci8zt2CWCCsLeYdfM3MIBCtyznydn6VvtSDg89vofVARQyV8l+8i6htsfb+huYjsf8z9DB+F9FkcPcI/+BwthSbyl9UDOnXPV+bjek0KmQsshRNSl48pVM5Njez0IHBBzoievO5KwRl/8H0O5kguHEuOq+AghqmVPmZP9xSPNBilBpkPXbzvP4c/gQM058hYIVRHg7OTs3doz9ULfVcmBWUKj1Yn9SHR6+lYklSchAoApg3Q/ovxly0WV/eLwISJ1S63EHogx1ANoyJ8cB2D0DPumnF+Qix4C79GhYp3wJnXfK/bouQdi+yh2CZPin+hY4pFQryAfZ+65TjUckfd0Idj1sOMCMl/4Wu8iVwXeJNL8PoFsBPufw8Y9LvRTk+qj4PvSZDKOW6xouMSE5uqCrIfJ+kfIPcy1FhJIugxYac
x-ms-exchange-antispam-messagedata: UvuvdYb76bVmq8Y8yluyrpJnBrMRfiigrk/8vETlAHOxX/ukn/nKNdgNZIhAc6cq7G2PxhLLewqnuh9zCcKyE6fD2MT/ymoavOMdliZLVMbUx4ftCMYeP2WoPxoxudhwU96xK0KIA6MCFZ9maOVAv7lUp9u/ry6gFIFipDbf8rw/QizqrDYhRKySP9hDEZPC39I/VdLbb+E2ip80P+tzdfBIpNYFHIN580eAMgHO4cLQsZh9Y6LEEqPzhwj61L2MJqX7e8Aa5AfOCg/haKCrp9EIK6AdCB8LC9UfgrkRoctjY+d2UWJGtvkjoafFZsMp7OF80BhFtj+ADuS44rPN93GCKuO1ep5uogGFTDEpwCyFWOmfCsHC3WFwHhX/niFr613reRfurN1sPUSlO75DH9EZUEPWIx+FXVsRkPeMS49YQlAkDSBxiiI8paY+ZDTR7Zfupjqp2AsjGu+6/cuySsAvi4TZyLQMpzSVa8oo6J5ux+Df2T1kadlr5BpWgHOAW6lxTy744VkD8He9uETyioiqxZinN1MK9j1Zn290vjODhYiFc4RtJBy2I3elvC9vt/n/rfkjmzQa/N1fgzH2Cwvq1ZtlRER/acnhT8DXY16AFlojyns5GGsOJG/bvuY9Px/yP9EsIOxlvRhfb37Jnh8AHIfusf0TpB8AFtRcqAYzjwzMIrh/0khmo5e2/gLixXz2CwFaWE6isiaaLHk0E7BLQYOHTbIc73ICGALG5DffsF95rdhQIsxxDGjiIg9WTDPNrCn4KrFIjJCQ1I+hVwrKy1Huykae4VT3Cl8Uxwc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef73b8f-6e12-4a1b-43e1-08d7ec32e4f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 11:46:02.8263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFPIkAt7PchsPiLDWIkR+tnexqABmq7Wvlfz33wBfkQqSQZ+AZTSrFLGfoeohQHFSRt+A2SKyx01Z1Ix47IPTN2pubBWTKYgByZC5Mw64nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3710
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've forgot to amend some fixes before sending out, will repost soon.=0A=
