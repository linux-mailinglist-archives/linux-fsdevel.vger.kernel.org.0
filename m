Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E577C1526C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 08:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgBEHRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 02:17:23 -0500
Received: from mout.web.de ([212.227.17.11]:43989 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgBEHRX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 02:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580887019;
        bh=SkuXuMRSS5wsjmW1Km6FqhwvLA7kjZhl46ps8ER7LZs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QGphYcNVzzD1KNUVIpoWJrFuoHWciBzd+KDuDMdRiqpGHHcj/+5hwCoOaVzDS8kWX
         s2Cv5G8gADm1cgf7J2Bed9G7HnwMfJ5+plfYWXbZ8tnAtGOp/fuGUnwAMJkW6lmz96
         4dZ3wV0HgKD4fdjyFc9hsIaJJDrglHdTxK0yS1t8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.89.156]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5OUd-1jkL6i01OB-00zTRR; Wed, 05
 Feb 2020 08:16:59 +0100
Subject: Re: [v10 1/2] fs: New zonefs file system
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
References: <68ef8614-87f8-1b6e-7f55-f9d53a0f1e1c@web.de>
 <cfb36fa5dcf97113198848874c0ca9ba215e26fa.camel@wdc.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b1336be5-16f1-cb46-3469-46974406de14@web.de>
Date:   Wed, 5 Feb 2020 08:16:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cfb36fa5dcf97113198848874c0ca9ba215e26fa.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hetht0YPM+njC+iNeb/3vZBWo6z7O1KizW6idhhrNAHpkNW0Bjf
 NojFku8iaOHFkMzfa/OICv/wZDyWCXAq8THVaoYNeulIJmMa+huTvq/50W9eIFCAF/NanlG
 aaWegDyR2FXt96aRnjYXt2UnUQl7Umog5MdAO6HaQwfaSV3s73s9MnO2IcAjMra1W/6x2jo
 I7oGdgJRb+F6PghnzMa5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AuR4KCRsJnQ=:prAEqST1n1TWRnf08QXBRh
 zw4qO7m/ZRyzI3FGcbnQBbA0VfivoME5CUrJgxCbIinjWhBFkylsNtsJe8y/UDh+cSsV04kMb
 Fns6yXxT0O/YmGy9AXWqw3CtLpv2RsxU9vdcx/H85rqF6LKGtLyoiOHxsB1ApWjLNzfnYUeAU
 /aMlpB9ZzlUcKPadtP/snap9yTRWJZ0lzBrLnAeAG7wxh891MebqoPjObx2e4Ke4BqWcPYf0n
 PMtiCBwcplBHsb1cqUxAnUOmTjldp+BTH1aqZWenbp0zGmg2EwN5ibuCtbpgexB44xsJ0uo5S
 koFT4KtxsR4djZVqdz4Ti42ldY+okH3gVtUcM90ggPLTS57QcTPbVdGhJThmja/ACE8A0lJfH
 OFyvCp3l3Pwr+VykSkFwmO1MB15qV6T/HvlNIS5HTtsfu1DpBj+piDtPbV3kh3DPCJmuLK36q
 81zWzzROoup9OKVHxIQSbKR2avXWP51z/RdxgfGiGLPSVhR67WLLa+hoIe3eRKo16/6KYY+Wk
 DyC2kI+QuOWpKEsR7lc560zVW9+7fIRkSl0MJQw/k7Erm3sF9uLf5EjzmRN6E2uy9JH7Kr9A9
 D+YfmkOrS6kp+IKS6ivighZ8Kn6gBBDdWs0WAYwifz66Z46MuyVn6dvHM7/fro0c7Mi+UW3M/
 9dYCn37yo6sHrDBEtdtvxphM00sdo8A70X0DrT6AuWmft5DRSGuwjaQVutWaNnl/Pq90+D8Bt
 bRXJ66505mwnbl5zLJ0KknyklGR5tp3DZfbCmtpjm1eK6VdXO/yZ5HvRm1NAbG4fk/EKvpyGT
 V2OPszPyHwFRkGdLx4x+dkQJ3JdJjSuHhIFad7Q4cStGVDA4q9wS1TplE9IaBcDZNp2mChppa
 vmDobyd/yMczmpjWFYuKY4REyUEpAUUjmeCfhAkgxC6H//10EdkSljMGbT/nq845oX12kTskn
 PpRWqwN2kuzN1F33FJB7oL7ZUCeLowrVviJCmEUQyt0amPK3qWf5Hxkc7UMiRwqVuB3NFef6K
 XohDyusB1QQSrmohgKCt1i3+YewmKTDb7pk725FgPV2ueDyPrsNgInMwesK1MOVU8x+Kunltk
 yib/v4oCJ1RxkUisO6nrWB+rNhEeTe49sARrC42fdG80vrHm8xGxmBuqKP2gvic3/kwUpfJlc
 qVZPQcTHfqqvx9YRdw4ZPWVXMNVv3rT3ywXr7ttN/qbUTP1dtkQ2M2LCL9WKJPJHBAX6za63P
 lEue8od3ihiMUtbVo
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Declaring it as
>
> static const char * const zgroups_name[] =3D { "cnv", "seq" };
>
> is probably what you are suggesting,

Yes.


> but since the string literals are already constants by default,
> I do not think there is any difference.

I propose to define this array also as a completely immutable data structu=
re.

Regards,
Markus
