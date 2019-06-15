Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEB3247251
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2019 00:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfFOWDf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jun 2019 18:03:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40894 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfFOWDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jun 2019 18:03:35 -0400
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com [74.87.88.165])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FM33t5000318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 15 Jun 2019 18:03:04 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0421C420484; Sat, 15 Jun 2019 18:03:02 -0400 (EDT)
Date:   Sat, 15 Jun 2019 18:03:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [tytso@mit.edu: Re: [PATCH v4 03/16] fs-verity: add UAPI header]
Message-ID: <20190615220302.GA19924@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


--wRRV7LY7NUeQGEoC
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <tytso@mit.edu>
Envelope-to: mit@thunk.org
Delivery-date: Sat, 15 Jun 2019 12:40:35 +0000
Received: from mail-eopbgr770119.outbound.protection.outlook.com ([40.107.77.119] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by imap.thunk.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.89)
	(envelope-from <tytso@mit.edu>)
	id 1hc7z0-0000We-JS
	for mit@thunk.org; Sat, 15 Jun 2019 12:40:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85lPkyWzKFtIowkDbKbdNSUiZ3aIlik29/tnGbK8ULw=;
 b=dx5Grr5QBqboHpoGZeM/rndRUEtYR2Qfxb3NDNxOGbNR/acVuMB3dwMo4WRguLBqMmIXaVK/kLQ7XsirNXuDMXvP4S/MT/UhKzsxMjrFpRK4bEBw/yy+07foKMvtMh+fKb2fDEE3HXexkreBCQc9glWf3GpCkQslyn/9MnhSqYI=
Received: from SN6PR01CA0031.prod.exchangelabs.com (2603:10b6:805:b6::44) by
 BN7PR01MB3842.prod.exchangelabs.com (2603:10b6:406:84::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Sat, 15 Jun 2019 12:40:33 +0000
Received: from DM3NAM03FT027.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::201) by SN6PR01CA0031.outlook.office365.com
 (2603:10b6:805:b6::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.15 via Frontend
 Transport; Sat, 15 Jun 2019 12:40:33 +0000
Authentication-Results: spf=pass (sender IP is 18.7.62.33)
 smtp.mailfrom=mit.edu; thunk.org; dkim=none (message not signed)
 header.d=none;thunk.org; dmarc=bestguesspass action=none header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.7.62.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.7.62.33; helo=exchange-forwarding-3.mit.edu;
Received: from exchange-forwarding-3.mit.edu (18.7.62.33) by
 DM3NAM03FT027.mail.protection.outlook.com (10.152.82.190) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11 via Frontend Transport; Sat, 15 Jun 2019 12:40:32 +0000
Received: from mailhub-dmz-3.mit.edu (MAILHUB-DMZ-3.MIT.EDU [18.9.21.42])
        by exchange-forwarding-3.mit.edu (8.14.7/8.12.4) with ESMTP id x5FCeP8p030213
        for <tytso@EXCHANGE-FORWARDING.MIT.EDU>; Sat, 15 Jun 2019 08:40:30 -0400
Received: from mailhub-dmz-3.mit.edu (mailhub-dmz-3.mit.edu [127.0.0.1])
	by mailhub-dmz-3.mit.edu (8.14.7/8.9.2) with ESMTP id x5FCePlK025559
	for <tytso@exchange-forwarding.mit.edu>; Sat, 15 Jun 2019 08:40:29 -0400
Received: (from mdefang@localhost)
	by mailhub-dmz-3.mit.edu (8.14.7/8.13.8/Submit) id x5FCeOX7025533
	for tytso@exchange-forwarding.mit.edu; Sat, 15 Jun 2019 08:40:24 -0400
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
	by MAILHUB-DMZ-3.MIT.EDU (envelope-sender <tytso@mit.edu>) (MIMEDefang) with ESMTP id x5FCeNq2025525
	for <tytso@mit.edu>; Sat, 15 Jun 2019 08:40:24 -0400
Received: from MWHPR01CA0041.prod.exchangelabs.com (2603:10b6:300:101::27) by
 SN6PR01MB4542.prod.exchangelabs.com (2603:10b6:805:e4::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Sat, 15 Jun 2019 12:40:22 +0000
Received: from CO1NAM03FT035.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::208) by MWHPR01CA0041.outlook.office365.com
 (2603:10b6:300:101::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13 via Frontend
 Transport; Sat, 15 Jun 2019 12:40:22 +0000
Authentication-Results-Original: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; mit.edu; dkim=none (message not signed)
 header.d=none;mit.edu; dmarc=bestguesspass action=none
 header.from=mit.edu;compauth=pass reason=109
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT035.mail.protection.outlook.com (10.152.80.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11 via Frontend Transport; Sat, 15 Jun 2019 12:40:21 +0000
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com [74.87.88.165])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5FCeHi9031504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jun 2019 08:40:18 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
	id 7B0C7420484; Sat, 15 Jun 2019 08:40:17 -0400 (EDT)
Date: Sat, 15 Jun 2019 08:40:17 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20190615124017.GD6142@mit.edu>
References: <20190606155205.2872-1-ebiggers@kernel.org>
 <20190606155205.2872-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190606155205.2872-4-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 1
X-Forefront-Antispam-Report-Untrusted:
 CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:SKN;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:SN6PR01MB4542;H:outgoing.mit.edu;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b8f4d1d-018e-40ab-dfa9-08d6f18ea830
X-Microsoft-Antispam-Untrusted:
 BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(5600148)(711020)(4605104)(4709080)(1414054)(71702078);SRVR:SN6PR01MB4542;
X-MS-TrafficTypeDiagnostic: SN6PR01MB4542:|BN7PR01MB3842:
X-MS-Exchange-PUrlCount: 2
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr,ExtAddr
X-MIT-ForwardedCount: 1
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;OLM:2089;
X-Microsoft-Antispam-Message-Info-Original:
 JXIyl/IzQH2IBXDqdja03ff30mIaTZFW37IR8PAg00QV2Jicc2mGctavffVswvRFgsMWuiP6BLT5rPkLI5YqnaHlUcQwK6hyb2Zozg3gxJy7sbw6UINIqBEtNI2sOzcQaN/QIWtNilyjBLOh4XvxBsX9U77eLTxMD6VLU0xF5MXFzLDFXVDHbtiurTiLi7wsbSUqYOrSX9zSaDsArDbFFOuf3VEgA7t42wkqnVZVPiFvk63NmOvijKx1m2kL3BJx1RsGcf+Tuq8VzBPQXd/uWv+ht4Yv0/aNDpJowEES45yeeKZjjHZsWdWmjN5t9ghlcBQ9SHFgO+EyBnlN/UiTewQaHT5a1jGGnmqIz7heZ2qAOfcRr6z/UC6QvnAgHZ7zqMMxbOkx5tV4DbOEiBTyDuIYJQL28kkowSnOqLdGAsa39VuuzolEPBmvbFMerBBmX4lsE1W0Xk9cu+e37KP816kv91ha7MoIskp+czGS6WLlwLjOGdR4KXjIpkQlA6SwdtHsfxg27DXj9dsj4+JaCCLs8nAEwnb3O3272kqoUS4vGs9K4N+508SJ8oWj+OjV8csEQs7Qioi+A+WjYFRUepk6AkS2oIgORwqdMRet6mfUJnom12gblqtSBEOI+z12XYBcZHeEXlTWqLQpIAQsfH454DhXWt58Gs6mg4zkH9KEa0pkjZfXSbjHJNk5lss1ZnHjXmdqZ419/T9uypsPgqUQHRknQpyf08OzmkmZSjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR01MB4542
X-OrganizationHeadersPreserved: SN6PR01MB4542.prod.exchangelabs.com
X-MIT-ForwardedSender: <tytso@mit.edu>
X-CrossPremisesHeadersPromoted:
 DM3NAM03FT027.eop-NAM03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered:
 DM3NAM03FT027.eop-NAM03.prod.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DM3NAM03FT027.eop-NAM03.prod.protection.outlook.com
X-Forefront-Antispam-Report:
	CIP:18.7.62.33;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(39850400004)(396003)(346002)(136003)(189003)(199004)(11346002)(88552002)(70586007)(2906002)(106002)(229853002)(70206006)(5660300002)(486006)(336012)(86362001)(36486004)(446003)(76176011)(23726003)(126002)(2616005)(46406003)(47776003)(8936002)(50466002)(478600001)(156004)(6266002)(6306002)(476003)(6862004)(103686004)(186003)(36756003)(1076003)(786003)(8676002)(15966001)(316002)(76130400001)(246002)(26005)(97756001)(4744005)(16586007)(58126008)(52956003)(6246003)(7596002)(42186006)(26826003)(75432002)(36906005)(305945005)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR01MB3842;H:exchange-forwarding-3.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:exchange-forwarding-3.mit.edu;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d48f341e-96dc-4c89-525d-08d6f18ea1b0
X-Microsoft-Antispam:
	BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(710020)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN7PR01MB3842;
X-Microsoft-Antispam-PRVS:
	<BN7PR01MB3842E6346181C545872ABB39B5E90@BN7PR01MB3842.prod.exchangelabs.com>
X-Forefront-PRVS: 0069246B74
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info:
	RDFZauVqBXpSyflpmfgcEDiiMpTPbec9K8sx1sWJd3yFe+G10NGYUIkRJt1gGDmO6FZh6afpBDmEsNHmKjh1uoI49sWcYeQw0kkunnPlyofBsK8O0zXyZHO20bBeMTgZbdN/AZsHdBPeCMgcDZFlPOOFjuPxDxLzm1C+XSosSvDE5M7G8Y76RIf+gDeFBEE9d4NAHEzU3BaOn+qVYrneu6hjGSTC4pSkBCe1zpX1/uk1geEZaFP19bykvrbZ70doPMs5+aNjK6HU+8/6yYLI0vw57riO2mZoUJT+de3GZNq2zJz+Shghfe0xMIz7AwDZqRQIaqAYIBT5SqyFMR+lz2k+lvg4ZkPRaeaFeGfO2ytnmvXcXxqHiSYM4iea40U0c1AcUxoGF5KrVvrTV6wGH2c2v61NmHbVqIxYG8yklnM=
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2019 12:40:32.3384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8f4d1d-018e-40ab-dfa9-08d6f18ea830
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.7.62.33];Helo=[exchange-forwarding-3.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3842
X-SA-Exim-Connect-IP: 40.107.77.119
X-SA-Exim-Mail-From: tytso@mit.edu
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on imap.thunk.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v4 03/16] fs-verity: add UAPI header
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on imap.thunk.org)

On Thu, Jun 06, 2019 at 08:51:52AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add the UAPI header for fs-verity, including two ioctls:
> 
> - FS_IOC_ENABLE_VERITY
> - FS_IOC_MEASURE_VERITY
> 
> These ioctls are documented in the "User API" section of
> Documentation/filesystems/fsverity.rst.
> 
> Examples of using these ioctls can be found in fsverity-utils
> (https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git).
> 
> I've also written xfstests that test these ioctls
> (https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/xfstests-dev.git/log/?h=fsverity).
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good; you can add:

Reviewed-off-by: Theodore Ts'o <tytso@mit.edu>

						- Ted

--wRRV7LY7NUeQGEoC--
