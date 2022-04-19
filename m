Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2D15067CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 11:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbiDSJks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 05:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbiDSJkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:40:46 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085A21FA78
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Apr 2022 02:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650361084; x=1681897084;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=hwk3q3w2C/k3DOjZgKgbKHZzctBJlVmRsGAcITCOV8fGni2LV6A/vyNl
   QXzRAiB/nq6ERYXaiLBINoyc87WlZn5pgW0ekF/H6xyE/4F0pAvCFMyyT
   MVN98JuUC2RmrMHzCgPBrdKgZ6OjEXZ7TTXOiQQVsY8VY1GT8u/avQVUJ
   TUpN8nqHZtvF13XDoG2qIDaDmXORJCDZKDcC5taE+G2kiZxZuWiGTCcYw
   Fw2C+CCX+AKtxJFa5mtKsp6buH5G59cjDNyLJySWprEefZmaBtZyG6fOG
   3GPBTPJCX4MBdVSy0+gfbwownZ7ibY8s0Gcg1wPH2G+/wJnGvpRTzsCs3
   A==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="197107705"
Received: from mail-sn1anam02lp2048.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.48])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 17:38:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfFNs7gbk7c1N1ISH9737txE6HVyq3Z61LWBdCE9lT5ItMN90tPsNfFA/OVNxO+fOPOKph/2ep+bXJMKFnUa5GCzobKAMWJYHYpLX8RCgjV8KGqDHbcNo9WXnAAU81PaSWzKL3WJbrIth3BtMPhJ1BwJoZkZpP/h72tsShhCEWwxrCDqjVSgZjvw1E+d/ZI8dW8rr7vmoY9hPmHjVmKPYx0q4KBCJ3uQ/R+pqrd5sGkuE1ohgDfhGXyYmB1KQEcviCGHw2T9NPHp3C1GWc224tnx+qzG98dLXu7X8FqaDd7gleUZajgVcNVepA4KZop+TZKtfVsa6QQf0EzULmlz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=b6YjG2G8oqbtioV5bZk1VD4bKdIM9T21B6q6Mduwc8LuTsMToWwnKVHxYDiQS+OKlFJ/jRL3GDZvheD4/Z7aF5yYv13uKrdVxE6oI2/SiId+jUH4mbQVhatPZX4FiQ4DsG4OcLntJaFSfngkv/rQHN4uA53bgGmVSkwFeC7qgYTtfSXECjpA4Y5kEP74NFRJYTzoop9MUVk6DieyU0gjSFRHsKcgdwTZJ1mikYsruXpoTuVA+KRHSYQemN6T/7OCLLYJKBh5QVE4HCUQ+P+gTtv1uzLa881p7yWHp5OXw1+V2cMQ3FDCY5TF1XaqDv8n0sFhfsExcugnhVx5wOstIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hFtO3pHOrE1DW25l+bQWvUJ21DOGmmYUj+ORMg6Ekqx4MTMEyC5aRDwmWpQ+NVA3UrP/zUpl0Hls4OubEF4sVWenjP2rB3CzFoinarp6ClS7KCxw82X74D7+irgO23GW5ql3ENuYoPzf8AFhYcEH5CQarZyosbxdfh13Bih3TmE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5258.namprd04.prod.outlook.com (2603:10b6:5:112::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 09:38:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 09:38:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/8] zonefs: Fix management of open zones
Thread-Topic: [PATCH 2/8] zonefs: Fix management of open zones
Thread-Index: AQHYUsFZ2ZP60ERYk0CTHi3WI8ZAUg==
Date:   Tue, 19 Apr 2022 09:38:02 +0000
Message-ID: <PH0PR04MB741664AE332D6050D02CBF499BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220418011207.2385416-1-damien.lemoal@opensource.wdc.com>
 <20220418011207.2385416-3-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 229dfe07-da7d-43c9-a365-08da21e84c7d
x-ms-traffictypediagnostic: DM6PR04MB5258:EE_
x-microsoft-antispam-prvs: <DM6PR04MB5258B4962923A02F85B293839BF29@DM6PR04MB5258.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/7nUa0XUaw6TDef53HNFS46B97TifdJggaP+CYXNK3/cCmZDnv3ndLGllgnCp8CvR0TivQLhmrdGtocwTwrr0tvav6sO1OqPsv3Q8GuySXRpzoXZUfF6N88BWENNc8BIJd0C9bcsGYi9Sbf6aXRUle5xqjuR8gT82wmoEIKMlvPjJeAhxkxGCIX3R66Zs/tNNqGVDErmYHdiJ5IPml6UmQzdLEKWPwl85dAkWEXsgxxK7RlAZmbPpXnOcw+fhKC3QjxoYAWLseMaSq+8dDU3z/75BmwxiLNPd5odad7qkFppGAAks+vbgS8vQdZ5HaEeBfJG2rKiaZJDEhh9tov3iaLYMiMDeNRIW5k3RJ4hm6JJ/FbfW7tQ/vlxzJJCWOLWjf/ucMrnShqo/s3ieIfyaMbeiPzy7m5mPknOwBZVVRWO49f6IwKpgU4ge5kw1Vs7d7MeLCtOOXalOXQAthLA4Y5rCQfKIb+1utQODAOqRRm2+J9dzcakp4zsGzQ01a8gtKWR+3oO5ltskXACnXcR4mbUDuHKRqJ80A/b/69X0/B7UzCxoECZrW7lOosX4IpAu4z5o53eVEx/7UTmp+H9nzzyAOA4z4a7T2vAgghUbSV1xC08/1NiJtPT3DdP0aRiHXd6dRgnSPe4VaYnDnPRuLCb0uV5RChxUDpFSXEQPqcHCu5FBEeAyzenyjgd+6JJBDSjoz5ljEIRR21uM6GQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(82960400001)(2906002)(66556008)(6506007)(8936002)(52536014)(38070700005)(316002)(508600001)(19618925003)(64756008)(66446008)(66476007)(86362001)(558084003)(38100700002)(186003)(91956017)(8676002)(66946007)(122000001)(9686003)(5660300002)(4270600006)(110136005)(71200400001)(55016003)(33656002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zK5JfNfrr0raP40dVJxW6CkzB7N138MwX07vOXe8vgtAR/T8pMTsPcGSAUst?=
 =?us-ascii?Q?hZGnMb7MNBFEqEZ6NR+bvRM3EF2VOTZuP/2OGXUg65cl4HJjzFlag3MDhTLg?=
 =?us-ascii?Q?nfjcQNsakNzmrQxaV/94oXUbKZ8adleaqwVDRBVEiChWZJ7MksfSC8ThsyHh?=
 =?us-ascii?Q?XBJPKArQp8qhQ/FRmOkPjd4+M11FuKVGmk99/+zl52CuXaTYIZvIFR4m9Bky?=
 =?us-ascii?Q?DYInB6zKOm9m32wAc4nKXptSGE+boK8B7uFJ43NGo1qhgVEYyK/Un5f6ZqN6?=
 =?us-ascii?Q?ktq9U06fDKUoU5OmCmHsHk5S3vL1RNt3J4UQrGrvRGFapl4VHgTBkDjWy9LL?=
 =?us-ascii?Q?P7S+JIe7l7ZRkQnqH/b88t3zD5si0P/fHvjJ3WAsmKfmh/7FwJg6ZC71mbjp?=
 =?us-ascii?Q?Y7eJDaOOv9eM7KY2FpNe/C+N5duHWAydnVQCpgHEYDOu79HkyAbAqv9MtCFi?=
 =?us-ascii?Q?nedxBeKMYlMzxv4zjfKe2SUVpd3XEK+Xqntfc7HZHQNnPtNLZVjKXShCbCMx?=
 =?us-ascii?Q?waMlKEhIJgxLfKvHzmZFG8UlJwE0KJ580qYiOvvJRloTFQLs/okPgV7SsFYA?=
 =?us-ascii?Q?MwI2OZaUxBrjrYwlVanVjq2lleL86Z43ZfMPe+jji+MDgd1ni9bKSMVLEosa?=
 =?us-ascii?Q?yhSxa1EkAfdx8nPQ1WRJ+HZY+dOsWYYjYjE/mC/y8lwDd4T8FwPVpH0X2EKv?=
 =?us-ascii?Q?YHW4MBqSHNjouljlfkTyNaS6hjcL7KPaNL1VwQzHNtBaFulRkx59YZAs2Nmr?=
 =?us-ascii?Q?Th067fJ8o90dScxyCQgy3mMzXqmAyFnRJzKTmagYqhDNtquWqenBLv22BlM2?=
 =?us-ascii?Q?jRjgrkw/XV4DiZRXlin9jOI3C2b26KnF4hXy6hAIlIAdZ5nM90Pi1ZJNPrVw?=
 =?us-ascii?Q?YCuQCYh2orSRwjk3sAPffHlYylMxFMlfAfKe/bHdR9sELLq1xxCePP6eZUbj?=
 =?us-ascii?Q?CBNMolJ+GE8SONZGaThjKaPNUvYNrzeEn+chtupBaIBAyfKvmz429TeTDPav?=
 =?us-ascii?Q?RQAidVmRw7U+HvSYNubzOoYKMUFjQZHXIjMmN/iaI7dH0WQHaGj6XFo5gajZ?=
 =?us-ascii?Q?m+dDATgfI9cPI8KBItZYbePEPDdaXbVgu5dz+tcrSlNmTuaqT/JlGf0NuUur?=
 =?us-ascii?Q?0fpfrImWzf1v/c/evAmB4MGaQUdN/r+9MrG9mMujW87H4bl4nqzQK51MsjSG?=
 =?us-ascii?Q?6xzQqnzlc78Jr1r9RcoollMufh5ljS8oSdqrXGm7W7LPr4ofDN50XpiA+Hay?=
 =?us-ascii?Q?AoHxNCnwf+SfhaYKIQ5lkCaB/x4fjVedPe23o3hHCFq1NCH7aOETCLN7yp+m?=
 =?us-ascii?Q?K2Jsp/Vro6OJHqcaEvMDHkHufVPJQbRfvOiAQom5dFRUoYC01XtrQ2ORfFmA?=
 =?us-ascii?Q?OO67iXo25WO9bbb5KdeXYQNyxnE4y0c8XRkAKXWdL5O7l9j1Wj9snFqYZ8PZ?=
 =?us-ascii?Q?3gMNpHqYd1/X+KbpoondVRpeL7CVpUd5d0PsUcIPV1ubiYEGo/COx2r+LSkn?=
 =?us-ascii?Q?jyj/Oa2VOMHDxPaDeLUgiNtmyooMYxxr+WmL+A/1KJNIIP3U/IiWki3imdFp?=
 =?us-ascii?Q?nASfbD0On4KXkncmiDpeWece1FR0A/GUVEDrpLEjCn/yFNMtnWylkeZyHzDa?=
 =?us-ascii?Q?ZMyWSHUkLB0cSCBhL1sjtvQU2pm0hA67tSHEEsgHShhfHukCyjV9lbtZTAvR?=
 =?us-ascii?Q?feuUO1JGU+/TtvjYe7/cvEM2u9dlkAUQ+fNi8ZV411AMyDyxahqmMbyrCBef?=
 =?us-ascii?Q?Hlb82DVrI6W8YV7vb0YOkINA4LY2zNq8/V86/7MB33lrihiTrSeGhUlWvhvD?=
x-ms-exchange-antispam-messagedata-1: O8pWmj3V48DbMrpm2dKP30dgRwoK9glIJTU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229dfe07-da7d-43c9-a365-08da21e84c7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 09:38:02.4684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPwFT6OlbWMzyBXZxtX+ijbcxe94Xft4rJb5eAQjOUD4KTvtVkFU8/nQfm4oLVI04DC7vZMqE5SiHgk2tnwT24sbsHs7i+0NX8+jS01zzi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5258
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
