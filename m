Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6141534573
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 23:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344217AbiEYVAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiEYVAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 17:00:32 -0400
X-Greylist: delayed 6837 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 May 2022 14:00:30 PDT
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B8FBA551;
        Wed, 25 May 2022 14:00:30 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PGte2e030554;
        Wed, 25 May 2022 19:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=FXH5Aixo14OcpZvaaOb6T73bMITOImrbV68uF3PReGo=;
 b=UUbCQNk4LP5+E1l/TxE7UNbh0yGSh06NQgjZvpnX/TillZyH49QugjVghra+CXd4reEr
 vnJVydvzfYAK9uHr9jbDi60ENKeCCTurnN9NrtJv9OsNvONNDT7HZYfljaVL4RrxPRA+
 rE1dqi2mt8k3PdOm0v+lINmK80cwpBQ0IwM4G21OrWWVuICC38m5fEWq7Fab4kPM/2KI
 EqizxSED6hbuFQBcLO1m7kCDt/6lRAVVjlqgmeu7NCcHijkPHiN7X8+kqJ/n9qJ7BRJ7
 TWVJr8eb18ruzocmMeiqVHAHduifNuSgI2/RfPQueULqRlxZ2q453XKxWuGNf1zC766C 4w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3g93uqs9s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 19:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L34ucy2EGgM0VeCMA2ZDSolFHfA0PMPOWsrd6KjpIyP36XhryVGCKfFV2XeqLovhGKarOdIbrqZOdaoWO6IqGy092c7vqjyqyDdAobUWFdgAqn1EELEFgKR1CY/kYT+Gp62BQhSFKOyXZl410ELFTzVt9Ap2Sde2wdhiI+5Dmy/Ipys8StfY6lbJjBQY9Fob0EyG4KuYwHdGPoU4nhnOv+SacSb714fWS+AMxLYkDQPOlhWphjblKoxD5YPHs72xQUav0ZY4xMgenkfGN2Et54QcAV93bD9snU1ipYfYCoiapZqTUCkBJ4MOXy+UCnGh0IVSBnxDALrD2wa1fhHt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXH5Aixo14OcpZvaaOb6T73bMITOImrbV68uF3PReGo=;
 b=GjoXp3/aR1xrNMVfKY1by2WWQssCLUOh7Z4ZYaVasy3fEswNLuJptVpQ0n+6BycMaQuOcCLbnMxJ6lK004nXqpWhhePIzd8jrWipMlk+GlTaObuz2eOcBskjOPIjVY05R9sqMICq5a+V52OyWRRGX78guPq0hmIqN2S1qty9Kl2BjjKkS2jR/YW7eaTmmiCHA7r2p2P7O7udqnCL7ovSzUME1oqBTJoKeOrkBe1IqkimDmSpEKNZKrhiex+mLFSaV9OFxZCGPJ/CrUXMEGWFWisy/uKwi8Lk7/3UqCbWmlAXm0lKEC/rBg4dWjvayvpdkBQI/8Adk75NoxAWOeXQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BN7PR13MB2499.namprd13.prod.outlook.com (2603:10b6:406:ac::18)
 by PH0PR13MB5050.namprd13.prod.outlook.com (2603:10b6:510:a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.7; Wed, 25 May
 2022 19:05:32 +0000
Received: from BN7PR13MB2499.namprd13.prod.outlook.com
 ([fe80::6d71:f79a:cbeb:b66d]) by BN7PR13MB2499.namprd13.prod.outlook.com
 ([fe80::6d71:f79a:cbeb:b66d%5]) with mapi id 15.20.5314.005; Wed, 25 May 2022
 19:05:32 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <fontana@sharpeleven.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "joe@perches.com" <joe@perches.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        "copyleft-next@lists.fedorahosted.org" 
        <copyleft-next@lists.fedorahosted.org>,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: RE: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Thread-Topic: [PATCH v9 1/6] LICENSES: Add the copyleft-next-0.3.1 license
Thread-Index: AQHYbuvq+O+5yJ1eNkGH1te7vK8zAK0vz1+AgAADYDCAABUcgIAACgiA
Date:   Wed, 25 May 2022 19:05:31 +0000
Message-ID: <BN7PR13MB2499BA2AFAC1C79197734D81FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
References: <20211029184500.2821444-1-mcgrof@kernel.org>
 <20211029184500.2821444-2-mcgrof@kernel.org> <87bkvo0wjd.ffs@tglx>
 <Yo5cxWghV/v2Fnzf@bombadil.infradead.org>
 <BN7PR13MB24998CAFCFB973C80549F308FDD69@BN7PR13MB2499.namprd13.prod.outlook.com>
 <Yo5xTwGLmbsgJhfM@bombadil.infradead.org>
In-Reply-To: <Yo5xTwGLmbsgJhfM@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7cee65c-03f1-4d57-f06e-08da3e818a4e
x-ms-traffictypediagnostic: PH0PR13MB5050:EE_
x-microsoft-antispam-prvs: <PH0PR13MB50505E4AA86F2F5F31E02365FDD69@PH0PR13MB5050.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zVJzVlkh3HuFIyBbCHJ1XVYG0mjThfWJQGdwlKWKAfgB1QjzHhmuviXE7rXm7liTC3EwbWu0rjweHzQF005xPiqz79ma3eutihbO30IxO/x67x4nsrE1vo9lV9GuNpc/AvjRGNEojnEbASrckd4xZLijioeUjGCCP6XGXXhnGXpRXdpxMH/HSjqqaeUhmHYYehk6izPvEaDXTCA4NCavbHIYWmAwR/47+qU37Juy7H3levMlDk4R9osUcn7jd1n9rDKVWUf4f6poI3VA4Zv0aLX/d+TfV56RO5nWuDhdCDov/4Dmun0+LZ0JnHFOmxXLIhi/fc2IfXt58B9FsB/5s6GCgka8kciK7ThDW02FEqjr0+e7McQfzFJuFl4E78CxFcRIo6E41YJsH0D80XWObuUY+JSg23PtUTdGWsIFVgaogr1r97kKpohylN+9oIvTE1S7d7ooyLBhmNqXiH5DNmmQVSyxcQcjj2B1msJh+VGeSCJ2S/jGo8Gzbuh9/35RTudjm6ZAlGA9vqQrmZm4UZCqvUL5UG3yrefQ51eabTFxdhuxOpvQLSrhdqP/14JW7TFIHEcWpcNcCJoN2VUmZoCXJ6IvS81uRn6r6S+/P4yoMZ3OyIH+j8LjOeyT9MgNQot7VeCPWQx7lKTZhztnpOncJma+mUcpGl6wdmyoK0ikHwydIj2XK7PFmvBXTK66cSkyVVUBuk3Jo3tCm16arqznXvRE5NrckbuwFd2ouBg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR13MB2499.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(33656002)(66446008)(7696005)(508600001)(71200400001)(55016003)(86362001)(6916009)(54906003)(316002)(64756008)(26005)(83380400001)(66574015)(38100700002)(38070700005)(66476007)(7416002)(82960400001)(66946007)(76116006)(122000001)(66556008)(4326008)(6506007)(5660300002)(8936002)(9686003)(52536014)(8676002)(2906002)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cYTvfmjuiSrdnhngU1RrcN5FPFUH80h023uhoQw39boUo3bsekOUOeBFJQv1?=
 =?us-ascii?Q?ABerI63wthxz4FaseMCNlXQePFY+hzjLcD6xWrSEMafx08EAuK5BStqjrjmE?=
 =?us-ascii?Q?P3og4oxFbhOAtFzT3AIjR1xg5WzfZylqzbBe1d7D+lTk4K49ca+dNLjPiKXL?=
 =?us-ascii?Q?6wUoEjD0NOjIRECA8Ib8Z+LMnxQHOTTaEEsx0qu5PCIuLDd1wlNvVvj1VVNo?=
 =?us-ascii?Q?NVksjzLbz/GLIbB5ohcoFoF4XVdKqG+FYBkutO/X2vqXEICIHqU2nFsfk0pb?=
 =?us-ascii?Q?txHW25SnWry/WQ4NcRAnhrjIn5rNTjHveo6Huvfw3Krrs/X/SLQBt5br+yZg?=
 =?us-ascii?Q?N3Z7AmeLwMcZaLUc89EaLqo7rZYUi/XEUcnJe1Ak08ybTjGCWtJnE5w7BSDU?=
 =?us-ascii?Q?DwljNhbIS1qenmNiifs3LXaoaRCkjXenvLFuQpS6/K/Rzw4V/apzO7Hxis6S?=
 =?us-ascii?Q?vjEZCgDlfgjlLUlyOgjdYdps2YJTG9GzHrpaSzRHn6gVbFYEN0QCHxDw4CAI?=
 =?us-ascii?Q?9Z9MK5iTXk4aPRmqDCaOLb5Qwa/DgIW4wtKZBSVT93d1XlyJoAf8W7FLXtht?=
 =?us-ascii?Q?su7GhAEarLwyvJ2EB3iEujt58h4tZSsm+J+FvNXAO7LYq3nG9RnsnVMLNz23?=
 =?us-ascii?Q?DiFmwBmxjFYn6J7Ij62An3bxToKtRCcDcA6ARkJtsDj7fhFQCiKwsF8HyTCe?=
 =?us-ascii?Q?1l6Hw8bUAE7jsSd30WfQgplxZaf/+pdI7zQREt3wt2fCbZnMZqF+98MlsGhs?=
 =?us-ascii?Q?8AON08QhzuiwoW30W5ONwYhd4O+QYYV1YnM2e/rHoel5CF8/q4rE/o9MY6yO?=
 =?us-ascii?Q?OgTQ+2/Xj7vapisbVf6MdfF+AaeD0P98n8q95u3mw2R4KPhRoT2zDmF+fkTj?=
 =?us-ascii?Q?lbKmV20AEpWdT6WaPejT2yj+BSRNMGz9kCqf0qodHdhCw2l6qaVp/RUMtIWR?=
 =?us-ascii?Q?CAJYviXTBiCcFL1VOJtf0eNATJDkiuw4rjK/bJG0qox+Lo68Dtm6Kycth61U?=
 =?us-ascii?Q?FZEXseuq2zDfw5yKtLKnOKbRKNO5RlVmLv8tK0C7/n6LgVHDhp3bJcVNuVX7?=
 =?us-ascii?Q?GTGXHOfU3XRA9PG0LXKGRw3e5H2GSDmSfNIRS6RVad/vpmr89C1TjS2m0kp4?=
 =?us-ascii?Q?GbwyckKV9OTVNHEamHh7wlDQJv5AHVm/jIX/RM6ciKvIrPmvzUZiHpFAyv0i?=
 =?us-ascii?Q?vAMa+bKpN2ZhhvCLRe1cyWJvy85pq92xly+HoeE//0sxppflD0vdKVa0AIQN?=
 =?us-ascii?Q?Rwv4gHbpBtbm5HV5zD8m5cC40g0SZp2WezcMQt87AMw0Jl3bXKr8HYr8Ige/?=
 =?us-ascii?Q?L2hufWf0FajqvTWuIgj+pBu8BHhFK8WEcFzFd/3Mjf4Xldt+sWesOMwvS+WT?=
 =?us-ascii?Q?JzbevtAcS37h6IIa93WMmsmtXHXMupZGfZW/WldNIs149wpYDqxp/ccSdiIz?=
 =?us-ascii?Q?I1RghDkXqKeeGRHIaGME6hUsZP1n+x73yO2X9GPfrOC3mDudMI6HEpJpajyX?=
 =?us-ascii?Q?F8EC8lG4UEOShLaMQ9hGz7IfDbbKyyY2zcPk7TJLbiqyJeXII750SsUwvBeH?=
 =?us-ascii?Q?L9srPFTdZkSAFKqH9WbZSsM5JqsJAIe4aVJil7SL3b+ZmPmbSEp4F9KDUGtz?=
 =?us-ascii?Q?qkoionIaO+s5h7FiGsXMXfHW0RuuJLxbhxsCv7uupfbH6iHPIcpopqNAq7aR?=
 =?us-ascii?Q?1c1QsdQTy67Gip8Q40XIkNlaca8Hy83wtBJ84wegu7JDLgWsS/z5CIe01W3U?=
 =?us-ascii?Q?1lSG1mMQuA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR13MB2499.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cee65c-03f1-4d57-f06e-08da3e818a4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 19:05:31.8322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8lKZnsxzxsyFGNAPW/7Yzik/ObPz+cKAyEoJmFDgSvZQvu5zjFYFhE12sXcpAXJrxExyyazi7dtwmmRyABuyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5050
X-Proofpoint-GUID: VWykq81qiRocszcx58mXr4NapnVJvqBa
X-Proofpoint-ORIG-GUID: VWykq81qiRocszcx58mXr4NapnVJvqBa
X-Sony-Outbound-GUID: VWykq81qiRocszcx58mXr4NapnVJvqBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-25_05,2022-05-25_02,2022-02-23_01
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -----Original Message-----
> From: Luis Chamberlain <mcgrof@infradead.org> On Behalf Of Luis Chamberla=
in
>=20
> On Wed, May 25, 2022 at 05:05:54PM +0000, Bird, Tim wrote:
> > I know it's being submitted as an OR, but I question
> > the value of introducing another license into the kernel's licensing mi=
x.
>=20
> As a free software hacker *I* value the evolution of copyleft and copylef=
t-next
> does just that. Some may have thought that it may not have been possible =
to
> evolve copyleft and work with an evolved license on Linux, but copyleft-n=
ext
> shows it is possible. Here in lies the value I see in it.
>=20
> I agree that we want to keep the number of licenses as small as
> possible but we cannot really dictate which dual licensing options a
> submitter selects unless the license is GPL-2.0-only incompatible,
> which copyleft-next is not.

Um, yes we can dictate that.  There were good reasons that the original
BSD dual-licenses were allowed.  Those same reasons don't apply here.
Each license added to the kernel (even when added as an OR), requires
additional legal analysis.  Corporate lawyers don't usually rely on the
interpretation of novel licenses from external sources.  They do it themsel=
ves.
This means that hundreds of lawyers may find themselves reading and
trying to interpret the copyleft-next license.

And here's the thing.
The copyleft-next license has a number of legal issues that make it problem=
atic.
Not the least of which are that some of its terms are dependent on external
situations that can change over time, in a matter that is uncontrolled by e=
ither
the licensor or the licensee.  In order to determine what terms are effecti=
ve, you
have to know when the license was granted, and what the FSF and OSI approve=
d
licenses were at various points in time.  You literally have to use the Int=
ernet
Archive wayback machine, and do a bunch of research, to interpret the licen=
se terms.
It is not, as currently constructed, a good license, due to this lack of le=
gal clarity.

Regards,
 -- Tim



