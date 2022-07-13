Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5858D5732F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiGMJgt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 05:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiGMJgr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:36:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3003E24F12;
        Wed, 13 Jul 2022 02:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657705006; x=1689241006;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BsQxbcHDS5PXdpZlnd9pcRkhHERf10QrbThzthvLEQU=;
  b=RaU4Sg0Cfi3nYQowYHkA8QWPcHZnt1v6mNzDMI5a/E0w7AU5oXSB3PSy
   UCEt94z/VZnzwt5HzzQnouNUD9Wy6WpNbJOdwaJu2rNniW4JXpq2nv4y7
   X1owmnTKEf5pwtWKVhBGx7fjBSEiMzhqOW85as3SkGSxJ3RNC4pzo3hlu
   Cxl5x7yFO/wd6jwk3pMNr+NEl74XZrGly7gGzFFGGeEy2pdsFxg3POLNE
   Ixa4kEvfQVXDXtPILhSCnvL5Hf2XRH9Hqfd1ykmqjVUmgx6JiWjKEONLD
   1F1Md7VGZ+VhauRvHszwW3Tdle9McjykgW4Nozz0rZg+o8iFks2a3GlKa
   g==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="206279759"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 17:36:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmddOk3KlQn+7LnCv3FP/wezcKuT61fLsO4CDuglzOch8BYLwapW50PsMUXw3d4spXBgNNY9iZFYauDKy9VjAvq9yKDVjn+xqmOTHPBqa3kxComj7v4PSXDuVDuc3eFXeK1SZ3z8cHMFW60eew6ORAf3YbVNltE3upr+GbVUV8bhsqUAQox8Yb8AGODrpuJk15AbOGlPVTDD0aBkqo6tO24pvb4pI9zJuMriM7p6RCTbL8W/vIu7cb9aOucUNKhp3Be4ybElrU+2LjgdL5vFzMLFfFUq474dUM7C5SmBZ4dLph6F9Z/SJDArqh5j3ntI+NOJq8F6ShkjZUGpQkAO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D++acP2aokmIlhEol82WWjoPeGfwVxcLhf9Yy58vu7s=;
 b=W/py5geidqpUd8qaXDLAiqu+J7l2K7WEWK7+w8b06KhYppHHl9IfIJNRlunXarHTZLI57UySFH+5Fubs9yrDPjfkhMGMF2FPHnOozpO/19UAoiUZxAKp+JuCilusNvPlPLjVGpJt6BxIk1FQ3RtpkjoxIXX9oN8M/F7dStH4yQGTWn3evpSYmTR5hMQK2qlnRAId85d7ZdrIMDWpyPFnv1Ev1GwvGXzvpfVy3Da1X+Ec1aevYIq6tvHL48d1811HXWTFDJFiVyNUc1JIje5mxDoqd7haEdvZu/5frPkV1X7jvQqJQe3xQ7cdSr7aTgeUfUUyTCqzQcLMjZbl2Om6Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D++acP2aokmIlhEol82WWjoPeGfwVxcLhf9Yy58vu7s=;
 b=DEY2f4jiAnMfwIjhSosgqPcn1kGsdFHaOi3vLN64JJyG5gr5D2SZkZsWeHY+lBCPmmjPa1YteyINArO6Wc4/cyqxe5THOOr6VeKhafQ/F8uvvgasW6DdZiagTjwelgSd7l6c7/i/IOFQMN+ER6FCsDazPaCpefy9HoIkh1RMneQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7662.namprd04.prod.outlook.com (2603:10b6:a03:325::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Wed, 13 Jul
 2022 09:36:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 09:36:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Topic: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Thread-Index: AQHYjGHLrTko3I1yxEO9BQEmDW6tZw==
Date:   Wed, 13 Jul 2022 09:36:40 +0000
Message-ID: <PH0PR04MB74161F58D05301F3C50680049B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220630091406.19624-1-kch@nvidia.com>
 <YsXJdXnXsMtaC8DJ@casper.infradead.org>
 <5ffe57d3-354c-eabe-ea38-9c4201c13970@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc2611a5-9043-4252-8168-08da64b3309e
x-ms-traffictypediagnostic: SJ0PR04MB7662:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bBs3AKsP2KucwvcjCnQHlGURtDMdt9BkR8TcS/0qkxRglgZjVe2z1DAEqVmFAVtrcZJ4DgqsuOi77Dvpgcu+aP+K79znfFnu0ZJ3XlJbWTDH7gfJrDd9Hpaykn6ajrqBa7P4Adft4loThzIuuulPkwceDxRoKiHc34//y42HxwCCfIOvb0Y0SE6+gjIm6ctjl07LTOB4MnoXsolNOnkwtd4lX70+qpuuaPuRJM+x3FvOcbl0fdBjvGfH6cwbg7q26+/J7wPo5QpWZaJjDmmyYwknWyk7XXs6CddlwvG7IBD4293Uii9Q5k5ykcjhtjA+qU5QgeKuFQh04Oft5sW9kQfzvcHWMZy4Qf0SCh5zJJbsAU5ufTVUFeH7SsRV4vNlNwPwTqoXS836ErWIyaUxXicno/V4K8wbP637Zq97zhaPY6NLtgB15F7/IXlja+qP+3Ignbln7GywoLnKU5+w7ISrMWt/Y873WA9fYAG9CfB1AboM5x0VwpcE30NVu+LNP5h9DSzW18mZ/REoZoaz44pIwW1QwaV0aknIwN2JtDYyiPBRPrdgNq/Nw+t0cefc95KlwY4h/ZnBjRQC8itbG0NjEhD9uqvRFh0ynrnZOP1azSfburvZ/zkbvmCOP3SA/0bAKv6ArAF0wN2RF0Afd8n252kKlkQKnt9zFyWK0hFSTQ0goCrko5tHAjijO3jr2MdUwcaxbmDwYCP5seNLnXh1AxQovzni4aI7xHqlG3JFMWCunkZVtLnt/jADrBz0J0jXCVntQ2TAVPeXzYE+HV6fj2zDc9cpfV1VvFLkStcY4EEu3RZxaYCnndlHs7KI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(66476007)(64756008)(66946007)(76116006)(91956017)(9686003)(6506007)(66556008)(316002)(7696005)(54906003)(52536014)(8936002)(478600001)(53546011)(71200400001)(110136005)(66446008)(26005)(8676002)(38070700005)(4326008)(186003)(86362001)(82960400001)(41300700001)(33656002)(83380400001)(4744005)(2906002)(38100700002)(5660300002)(7406005)(122000001)(55016003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BbpiKS/AAkUAi80718vwCpUTtjD5TaxmMMBnLkC3NvM0pOyEADzgWaFYKYVl?=
 =?us-ascii?Q?JQ/jmMMGUZMdaW+/f/8XSnDWZYDC0MLL1+XBzAmOI33aaoctDivdKmoPT4tC?=
 =?us-ascii?Q?mYS8kVzNSdhqo3ErMEdHJ9JvxhpvDT92M+4WHYXnf+1BfQNzmxh/3f2ERg1d?=
 =?us-ascii?Q?64wT0QsHzjsWA3DAxttAlFqjIHTAFW9mOa9M76ksYBNOxlFzEspF7LQb8LN4?=
 =?us-ascii?Q?4zHf/Yx76tDXHrYWs+0CRbv2HS18OANbtF1Hw3XrKZm7Yq9ZLepB84fqjnpZ?=
 =?us-ascii?Q?2le0fu5XHgAf4KxVfe39uIXe4X9aZTBTZeMoQC2SuG/88cjUhFjElk6MSQP1?=
 =?us-ascii?Q?u23Y6T8bV+EKZfZqC+M+xAABxuPOMRv1z18A5Ba6yMBXlhPXgVQK9Vj7F48m?=
 =?us-ascii?Q?v/a2HNouYiC3x+KKykhTVxoAcA7niXpmMFi2IEAFC0/xpEf1trF0auORZHKf?=
 =?us-ascii?Q?kAQX3eaPzgVZ3mvsnChD48koezWgYteSfyyLHPewp+vsT0nBUb9k2k6Vl30s?=
 =?us-ascii?Q?/AitCz5O8q3eFrUEAswHCVAfv2x4PwF7CnlIOMKNc60sKA+mpA/NusNTCSOM?=
 =?us-ascii?Q?X5f0j0NCHPhX6rqx+lnxgtIKeUHZ9bCcsDB+2KjLhLBD6U+cQwPOjGR92RwR?=
 =?us-ascii?Q?uOgCKAPKJm3bEoYTzQ87NT60KvFgLrb0zKv6M5gBlJpNjOTjOJ4TTgVL4vtD?=
 =?us-ascii?Q?sfupOsbstt375EsglacwfNJf4KsrOTT6H81QDCue2WlZtvY9qeidFo5o2uMe?=
 =?us-ascii?Q?YhvjMTXL2P+GE1Yx/g2u9jtwGUNv7IFRqgGrbgSTVXA9Fc5lj5CvdJTpLs0R?=
 =?us-ascii?Q?G66PkZzQ5d5zs+0p2R1Ep6llMnirEmqZj6jUluHaS/DFTs7lGqiX3N+1rXRu?=
 =?us-ascii?Q?4pwnvAbZZFI2TZepwfYdPoTlQl46PwIlaeDptNr8cKF5dkohPjnHKdcQVFID?=
 =?us-ascii?Q?R4hacx1NVA29QzeVAfyLrWzkFeNSKg1vyk7YvhqnS4cR5POqbxDK7/l33cw6?=
 =?us-ascii?Q?qrwRLixhkFfcK601orGAQkGklYFBVIzGWKDzOEzbSSTdp5ilyyiXnmjV1/xk?=
 =?us-ascii?Q?sihGtFWQvmdI3tPS7n8WQR57Knt0bk9bSKIsqtUCLTM8F+fg8aa8yvqeyl6b?=
 =?us-ascii?Q?+QZy/Lat0bDgtMTm4sht/BiZ8U2+A0qIslvCR7r+S8gN6A271TrXkY6Rn11p?=
 =?us-ascii?Q?fJHw0XYgGlw2r+lngdEuhIUv3pStsAXgJWMn61yiM8WeaK+JX5qYOhzExp/e?=
 =?us-ascii?Q?UIvdcqZvALdMQ8BeZ4nAMnPXcK/ZrK3ncqtqaWHUSFNsWBYaQeZysNJeql0f?=
 =?us-ascii?Q?J/I25yDCrn8goaGO1LNDEq/S6rSPmE9sHwQ6I48XlPu4FrR64QJ+rUCTpNEr?=
 =?us-ascii?Q?AeHp7Y3OzwK4x/poNnR0qqW8o00TSS8aQs6baVfwqgqSZDreFRs8hgFIiVtb?=
 =?us-ascii?Q?X2l5bD+mBQjeEtcioywV/px9NvdcrF80K2HGHCPaBTbxcUfdI0DqCcgX80+W?=
 =?us-ascii?Q?0zFb8dB37uhyv/aPgRRlrje/ikcFvKgmT47TA1Y77pLTG9V3op40Juperi8f?=
 =?us-ascii?Q?qGEafWDZdP6bibGUVp6LvJ08g0HbV/vOuUPwf6lQg9TJSVf3wfFmdawiGRw6?=
 =?us-ascii?Q?VF26jsVTtVXRW2AaW7ArBrk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2611a5-9043-4252-8168-08da64b3309e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 09:36:40.3808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBJo3St95fQ6JAEu8s/WK+fmM6wlFCz4XLs/DX97CtAm+qsMSSa5RYlgNxrtTRSBl/In36v4KLTmEbuuzZ7N46cojiJCwKK5PZLG2bN5qpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7662
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13.07.22 11:14, Chaitanya Kulkarni wrote:=0A=
>> I'd suggest calculating some kind of checksum, even something like a=0A=
>> SHA-1 of the contents would be worth having.  It doesn't need to be=0A=
>> crypto-secure; just something the host can verify the device didn't spoo=
f.=0A=
> I did not understand exactly what you mean here.=0A=
=0A=
I _think_ what Willy wants to say here is, we need some kind of "out-of-ban=
d"=0A=
checksums to verify the device is not lying to us.=0A=
=0A=
Something like the checksums for each data block that i.e. btrfs has. On re=
ad,=0A=
we're verifying the calculated checksum of the payload with the saved one a=
nd=0A=
if they're not matching (for whatever reason) return -EIO.=0A=
=0A=
As the device doesn't know the location of the data checksum, it can't spoo=
f it=0A=
for the host.=0A=
=0A=
(Excuse me for my btrfs centric view on this topic, but that's what I know =
and=0A=
what I'm used to)=0A=
