Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA101729BE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjFINqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 09:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjFINqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:46:01 -0400
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBDD3A8E;
        Fri,  9 Jun 2023 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2744; q=dns/txt; s=iport;
  t=1686318335; x=1687527935;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pZJ2isdBXf26opFfyW0K6wfpwV9aMXdacypDBWmpHWU=;
  b=fUyRSOz/3YzweT7hkszfsTsAieBwLlFCOWvFvgW08RDw3kqJiatjgxOH
   VW2K6lhD5eLj7P1+YJZ3/fZpDHHQk2vvwmB/34XU9wgiv1zEE2oTLQEDw
   OhOHO4tkX9yd5hh0NPOK5M9HWTeIk7s7WMs+DMhS5+QKXfY3+nRQ7HZHW
   o=;
X-IPAS-Result: =?us-ascii?q?A0AFAAChK4NkmIsNJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBFwQBAQEBCwGBXFJzAlkqEkeIHQOFLYhSA51rgSUDVg8BA?=
 =?us-ascii?q?QENAQE5CwQBAYFTgzMChXQCJTUIDgECAgIBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBBwQUAQEBAQEBAQEeGQUQDieFaA2GBAEBAQECARIoBgEBNwEECwIBCBEEA?=
 =?us-ascii?q?QEBHhAyHQgCBAENBQgaglwBgjkjAwEQoR8BgT8CiiR4gTSBAYIIAQEGBAWBT?=
 =?us-ascii?q?gMPL50XAwaBQgGNLoQxJxuBSUSBWIJoPoJiAoFgAoQSggwiizUHBwYFBoJig?=
 =?us-ascii?q?wori3SBKG+BHoEifwIJAhFngQgIYoFyQAINVAsLY4EdglUCAhEpExRSex0DB?=
 =?us-ascii?q?wQCgQUQLwcEMh4JBgkYGBcnBlEHLSQJExVCBINaCoEPQBUOEYJbKAIHNjo3A?=
 =?us-ascii?q?0QdQAMLcD01FB8FBGqBVzA/gQgKAiIknkIDg20mBRQIEAUbD4EWbkTEBwqEC?=
 =?us-ascii?q?It8lToXqVWYFiCKY4JXmjICBAIEBQIOAQEGgWQBOIFbcBU7gmdSGQ+OIAwNC?=
 =?us-ascii?q?YNSj3l1OwIHCwEBAwmLRgEB?=
IronPort-PHdr: A9a23:sRXSlx/wBJXoQP9uWO3oyV9kXcBvk7zwOghQ7YIolPcXNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8ERHER98SSDOFNOUN37e0WUp3Sz6TAIHRCqPA90LfnxE5X6hMWs3Of08JrWME1EgTOnauZqJ
 Q6t5UXJ49ALiJFrLLowzBaBrnpTLuJRw24pbV7GlBfn7cD295lmmxk=
IronPort-Data: A9a23:TASXfKDVOWe6VRVW/wHjw5YqxClBgxIJ4kV8jS/XYbTApG8ggWNWy
 TYeD26HOq6IM2ugc9twbY6wpktVupWAm9BhOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4WGdIZuJpPljk/F3oLJ9RGQ7onWAOKkYAL4EnopH1Q8Fn9w0UsLd9MR2+aEv/DoW2thh
 vuqyyHvEAfNN+lcaz98Bwqr8XuDjdyq0N8qlgVWicNj4Dcyo0Io4Kc3fsldGZdXrr58RYZWT
 86bpF2wE/iwEx0FUrtJmZ6jGqEGryK70QWm0hJrt6aebhdqoSFp8Z88NMAlTQQOsDe5rsgq5
 tZxusnlIespFvWkdOU1Wh1cFWR1OrdLveGBKnmkusvVxErDG5fu66wxVwdtY8tBoaAuWjAmG
 f8wcFjhajiKguO93bayUcFnh98oK4/gO4Z3VnRIlGiGVqp6EMCbK0nMzcVD7jQUiftrIfbbZ
 voERz1zSSjcOBIabz/7D7pnzLv32RETaQZwsk+Oue855HKWyA13zajFLtXYYJqJSN9Tk0Leo
 XjJl0z9AxcHJJmR0jaI7H+orvHAkDm9W48IErC8sPlwjzWuKnc7ARkSUx6wpuO0zxD4UNNEI
 EtS8S0rxUQvyKC1Zt7wBD6Bp36+hzpfAuFSI9wisy+O9qWBtm51GVM4ZjJGbdUnsuo/Sjory
 kKFkrvV6dpH7e39pZW1q+v8kN+iBcQGBTRYNXJYEWPp9/Gm8d9u30OXJjp2OPPt5uAZDw0c1
 NxjQMIWqLwJiccN281XFniY3mrw/fAlouPJjzg7s0qs6gd/IYWifYHttx7Q7O1LK8CSSVzpU
 Jk4dyq2srlm4XKlzXPlrAAx8FeBu63t3Nr02gEHInXZ327xk0NPhKgJiN2EGG9nM9wfZRjia
 1LJtAVa6fd7ZSX6M/UrMtrqW5l7l8AM8OgJsNiKNbKihbAsJGe6EN1GPiZ8Iki0yhF3yPFjU
 XtlWZ/1XS1y5VtbIMqeHrdBjuBDKtEWzmLITpez1AW8zbebfxaopUQtbjOzghQCxPrc+m39q
 o8HX+PTkkU3eLOlOEH/r9VMRW3m2FBmX/gaXeQNKL7aSuencUl8Y8LsLUQJKtQ0x/QIyr6Rl
 px/M2cBoGfCabT8AVziQlhoaajkWtB0qndTAMDmFQzAN6QLCWp30JoiSg==
IronPort-HdrOrdr: A9a23:uXeuCKvnYokYHbcTREeG4YWL7skC2YMji2hC6mlwRA09TyXGra
 GTdaUguyMc1gx/ZJh5o6H+BEDhexnhHZ4c2/h3AV7QZniZhILOFvAs0WKC+UytJ8SazI5gPM
 hbAtND4bHLfD1HZIPBkXWF+rUbsZe6GcKT9J3jJh5WJGkAB9ACnmVE40SgYzBLrWJ9dPwE/e
 +nl7J6Tk2bCA0qh6qAdx04tu74yuHjpdbDW1orFhQn4A6BgXeD87jhCSWV2R8YTndm3aoi2X
 KtqX242oyT99WAjjPM3W7a6Jpb3PH7zMFYOcCKgs8Jbh3xlweTYph7UbHqhkF3nAjv0idprD
 D/mWZlAy1B0QKXQohzm2qq5+DU6kdq15Yl8y7AvZKsm72geNtwMbsxuWsQSGqo16NnhqA87E
 qOtFjp7aa+ynj77X/AD9SkbWAYqmOk5XUliuIdlHpZTM8Xb6JQt5UW+AdPHI4HBz+S0vFtLA
 BCNrCU2B9tSyLTU1nJ+m10hNC8VHU6GRmLBkAEp8yOyjBT2HR01VERysATlmoJsMtVcegI28
 3UdqBz0L1eRM4faqxwQO8HXMusE2TIBRbBKnibL1jrHLwOf3jNt5n06rMo4/zCQu1D8LIi3J
 DaFF9Iv287fEzjTcWIwZ1Q6xjIBH6wWDz8o/sukaSReoeMM4YDHRfzPGzGyfHQ0cn3KverLs
 qOBA==
X-Talos-CUID: =?us-ascii?q?9a23=3AVYz/qmkGWGmsIY/NqTf0qzDhYabXOXrQl1TpJE+?=
 =?us-ascii?q?CMEIqEYaXeW6Io41nr8U7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AjlgpBg8AtVoPFW2WxGy01xiQf91z0aeKB3sorZU?=
 =?us-ascii?q?DuvmZGytsHguB1zviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by alln-iport-4.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 09 Jun 2023 13:45:33 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 359DjXmX015488
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 13:45:33 GMT
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=amiculas@cisco.com; dmarc=pass (p=quarantine dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.00,229,1681171200"; 
   d="scan'208";a="2810536"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by alln-opgw-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 13:45:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeJS03g3+JYfkiLmHBBmRAZEc4l/NMwNWmuz+rCG3YyOsxGfAcMaFSv5To69f98YrnK0Kma3p+9tz9Rsl0VVB8weH0lAtZiWKb6LGeV4giIGPXqUaLYPhzewyPPJWBhxu3YzrMm7q+xq95MaF9F5+JXEoGoCC49vVVkHZpiqe6ztWSRnXI+UnkWudBTrzueAZHwqOAgpmtAsxJNHROyQZo6cSQe2eVHl956xX915lQTHOU8wKr4oLmYOfgaguHWs8bC8O3YofxiWxujQsfZgzi3jw0U6MXb3mfyBLGqaC0P6Gt8jjl2na4l4Mv8HXt5u2Wx6KUYDS43Y1v0iYGTpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+sv7AF20Q9Gj1rrjUokZduL1H80EAnxk9Q/f3Uy9fM=;
 b=JYSHMdwP98HoHgSJlQPJFmuPkABjYQOmS9yu/KpLSrD0uGDZUpW7mjExW3v056CYqrImjtFP4fGZmAYq5iVxsXIsCwDayHaRQ+rP8rcelH1M4/1F8CXIcrtnVMt61WbOpmQTsZrRrN28/EGFaCRLo7dXlsczOGGbeIczttdKQCg6ebg0IdrUzaYr/JMkW/d/RYOcuqbm80GECn7LwaAXt+6yuvaNPsCi4FKzHmsnQa6CsjpwYtuC4NhEGY8nsa3/l4m1aRU8hNE11+ZuHHCJDRBo3o12wL+oOft4f18Edu4qKhOBCglT9c7gPZCXZGlKGizMfFG/osLDAfLZzWElrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+sv7AF20Q9Gj1rrjUokZduL1H80EAnxk9Q/f3Uy9fM=;
 b=IkeT1MPgvc6qirRKdOAer+kLCmzdSR++RdBnB1osymPguZjS7sKE81yjmTI6psajdJWcxbmoEfXpI7KokYQaKXvEd0O5fge3Igf9PeC1JOH6uv9Bw7Z7+68hpzfAftPy4uuBLrLgv5c3+CTu4SZhFJ69Qgv5C4vpRbDEsKwYbYQ=
Received: from CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 13:45:33 +0000
Received: from CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae]) by CH0PR11MB5299.namprd11.prod.outlook.com
 ([fe80::d6a3:51ad:f300:ebae%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 13:45:33 +0000
From:   "Ariel Miculas (amiculas)" <amiculas@cisco.com>
To:     Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Topic: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Thread-Index: AQHZmpwNhDd19o/UvkKcR6DrdZh/0a+CR0eAgAAG6YaAAAxbAIAACcwAgAAWrFA=
Date:   Fri, 9 Jun 2023 13:45:33 +0000
Message-ID: <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
 <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
In-Reply-To: <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5299:EE_|SA0PR11MB4671:EE_
x-ms-office365-filtering-correlation-id: 06ef2c27-0187-4363-a04b-08db68efcc02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qi6EONpu2WKDHrFJqO/nTHy0nF2iBw9+DSH5ShrrJrhO+/5Sfi4OYXiy9nZN61VNQxcHggbyfT5It7jDotoD++GnnDzK5sffb5lLehm+X0Ype2ENVLQIBTuO1E0EwIldNxUUGObm/psi7rtTQ4f0XZVDCad+0Qbu+48C6lvs9TamJIeicpmGE2dycQOpX/uaGXW/O2ApJoXw0Ii/K5RcFLVMXd5QnO4kNZ0yBVRSrHhNiVLo/D4BhKsozzkfMUkyHyzYWDqcT+cr/RMSRbdIxRcNasFj6gze2lG3gWn8IRvDvbxZN6A+yIPvECBUFLE66lpzhrwOKcCpfp/kXb6IoH64IVPc2uFL5IpimCiFyVogKHuN3te+UX7/OFr+RQprFIcWZx2cqxfwQ52Tao1p6vt5xXssIc6qMhvlI6EBZG0eZG10xmyJGl0udWxJkGNLEWnOTXeZ6ixiWiqX0mtkjWg3eUVAKbOfTTnsfmE9mAqfyJLAr16qbaMG9lriMUpSA7kdZNThbOBrsW2zxavFHr9umovIysp5m4REYjLBo5aI+mfBvRTuXk7tpV7n6pwnvKC6/vVWYwqhdCKRexCFCzXuAyevB5f08+XSQVswHsJU+Y9efzKzDYKv+EVpB6i4jVnw93XaSsZnyp0aMEXlww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(53546011)(6506007)(9686003)(966005)(83380400001)(186003)(64756008)(122000001)(66476007)(76116006)(66556008)(66446008)(2906002)(66946007)(7696005)(33656002)(71200400001)(5660300002)(8936002)(38100700002)(8676002)(38070700005)(52536014)(91956017)(110136005)(54906003)(55016003)(478600001)(86362001)(41300700001)(316002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HBdVHntKfk94k5o7eGWgmisY3zBDfVwtfbvqc86nkDpnkOJeY19m1J1y2FsF?=
 =?us-ascii?Q?Ubs10UZA7Cf4QD+xnwTuh4b1CrCFLYAHqJWwBqLixuXCRtgIKWRrz+h5aqkO?=
 =?us-ascii?Q?4+8ELmgsfgxqN5WpQyifXcfHrAA8d8hff+SuqnLY+WBe1fV+vtVMUkE8ftF5?=
 =?us-ascii?Q?y8fe1aWOuI7mwdkYrPitTVEnFLweT/tC/WtjAKEzwhsMyB+FJBPQw9RlYywK?=
 =?us-ascii?Q?I/TQN8DWYTX2QUnUpjgykyMK1bmlRggoPmZuPcLD4RSfdYBCx6+1WLQv/kUf?=
 =?us-ascii?Q?JYnTJC9ffhsrHzJk1xQF0p8pmB/veFVpgLn/NIiz1CRBfZiiHr2uc6bamZgv?=
 =?us-ascii?Q?sa2MSZ3a2WkPFKJY1HSaTa4pMfFNoVBoTccWok3llD23MNVLrxLYZCfO48F/?=
 =?us-ascii?Q?Zk3ZZTKbS9XTVKGqQyahXt2BikNI7B2GQuHgzlTaXs49KEiTRNs+m/Mwg/kv?=
 =?us-ascii?Q?gy5yB5qrQNIMEv7Ki9taT3JAv/jfxighuj/Qq0BSqGTCxAyRdrVhCS8aeEj9?=
 =?us-ascii?Q?G9Ic/szSTqoi94SpQ5ixR/zk8rYPiaT/rcFjgMps1QI3ijcJwGDNXn0GAtjS?=
 =?us-ascii?Q?GAUHcYstK7qI7iiu4UnHNi9MIX6/7KXYhbr93EFY7dpmRd1Lo3+veNwdC/Sh?=
 =?us-ascii?Q?LCAiqsc8ujArpS18lytZWO3FdnGCZEcKPOHHQG1glDrp3KnKXYC7ds4kDa4S?=
 =?us-ascii?Q?9JAvup9qHz5a1Do9dYyIp3o8e3mi2Mdj2vlEem0XNu0BQebVdRjDoNIrGAMO?=
 =?us-ascii?Q?d3aUYJwB831YP4O1w6EFbSX0szUdEiJbgJOJ5CvxW72xTlNNyTywLpKqh9b6?=
 =?us-ascii?Q?vWyMCP/JVWrFoEjt9wkZfudlaB4HO4eMb9Q7amPKGounvrkVcZhaoFYwWkc5?=
 =?us-ascii?Q?jKiDQb6glVyILmagMiHqbJrQ7LBnnzjgCEJ4WdxvGGolCoDChRNdZqta3sOJ?=
 =?us-ascii?Q?fkaeoSJJDjNZQV0TGMpG9JJ6dHAbD9x/ab6O1g/WVRAskmf2sq+U4rz1WEjd?=
 =?us-ascii?Q?rGADRbl7eRip8lM7GpB5ziGcj10F30PCf6cC+K35LxMbp2jw27Sl4e/0HCMR?=
 =?us-ascii?Q?1ODJg8igniEn0cAe8RA5gBUcS5I86MqzJvPQ0IWfGFOy19JocdMwMtG3QJ/4?=
 =?us-ascii?Q?MYxgzgjbouEJ3NjsihR/a3KJ3GnQXTh74wJpkvxEZ5kbOqVVJXpHrHVgG8lc?=
 =?us-ascii?Q?lgWT0A89kZcIz3nNuECw0bjlaGdt+FT+48wEXAmrB0Z0mbtmGoAHg7GwjZ2r?=
 =?us-ascii?Q?qgswiN3p91kUX2sc+URHbO3D75qBBhUe7Hz9Njp8dnSefnIf5tnjn+ZWaEBC?=
 =?us-ascii?Q?UAYNNBkp9YNfC1oJkk/xbJt2ZK6KsXUXV11T0RBmXC+qpkuCVe9FSflQqKYL?=
 =?us-ascii?Q?M5Da5c09MTJr9M5Oky8mRBZgk/Z0kFT7OPNhNHbFikeW2RY2pi+XsidFqnQF?=
 =?us-ascii?Q?yX9yCgeE1ogYOy05U/yutNOocBLTlpQSBMf1BqWI35G0RYDzMnSHyeKZzGCV?=
 =?us-ascii?Q?3z/uj+sbffHkauiJX22v1XoMGgLENA7NWxU+QS1QYwbW78zWpEcqLl3mbaM2?=
 =?us-ascii?Q?stPutJjtYscVdPKH/KuIWkKKvyZSuIRwpdj2kylrRb69uJd9Kny0+a3mVCrl?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ef2c27-0187-4363-a04b-08db68efcc02
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 13:45:33.2173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcUs8R9D2Ymg0Y9OE3MfnzglCey7xGzQqND+oMx/IfVmGjuz0bOBHD8ii9uLi9oka2t3zJQszZocOmF1kvrDtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A "puzzlefs vs composefs" document sounds like a good idea. The documentati=
on in puzzlefs is a little outdated and could be improved.
Feel free to create a github issue and tag me in there.

PS: as soon as I figure out how to turn off the top-posting mode, I'll do i=
t.

Regards,
Ariel

________________________________________
From: Colin Walters <walters@verbum.org>
Sent: Friday, June 9, 2023 3:20 PM
To: Christian Brauner; Ariel Miculas (amiculas)
Cc: linux-fsdevel@vger.kernel.org; rust-for-linux@vger.kernel.org; linux-mm=
@kvack.org
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver



On Fri, Jun 9, 2023, at 7:45 AM, Christian Brauner wrote:
>
> Because the series you sent here touches on a lot of things in terms of
> infrastructure alone. That work could very well be rather interesting
> independent of PuzzleFS. We might just want to get enough infrastructure
> to start porting a tiny existing fs (binderfs or something similar
> small) to Rust to see how feasible this is and to wet our appetite for
> bigger changes such as accepting a new filesystem driver completely
> written in Rust.

(Not a kernel developer, but this argument makes sense to me)

> But aside from the infrastructure discussion:
>
> This is yet another filesystem for solving the container image problem
> in the kernel with the addition of yet another filesystem. We just went
> through this excercise with another filesystem. So I'd expect some
> reluctance here. Tbh, the container world keeps sending us filesystems
> at an alarming rate. That's two within a few months and that leaves a
> rather disorganized impression.

I am sure you are aware there's not some "container world" monoculture, the=
re are many organizations, people and companies here with some healthy co-o=
petition but also some duplication inherent from that.

That said at a practical level, Ariel in the https://github.com/containers =
GH organization we're kind of a "big tent" place.  A subset of the organiza=
tion is very heavily Rust oriented now (certainly the parts I touch) and br=
iefly skimming the puzzlefs code, there are definitely some bits of code we=
 could consider sharing in userspace.  Actually though since this isn't rel=
eated to the in-kernel discussion I'll file an issue on Github and we can d=
iscuss there.

But there is definitely a subset of the discussion that Christian is referr=
ing to here that is about the intersections/overlap with the composefs appr=
oach that is relevant for this list.  Maybe we could try to collaborate on =
an unbiased "puzzlefs vs composefs" document?  (What's in https://github.co=
m/anuvu/puzzlefs/tree/master/doc is a bit sparse right now)
