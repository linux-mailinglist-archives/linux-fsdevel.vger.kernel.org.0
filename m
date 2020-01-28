Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E32B814BDA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 17:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgA1QZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 11:25:55 -0500
Received: from mout.web.de ([212.227.15.3]:33989 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgA1QZz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1580228693;
        bh=5zEqEcZAWVjGp8xkcQEhydEZ+GyThYQytTy9UD6ojXA=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=UE1JPMiCsCDfislzMWPYW+KkuOCy8pafU3ju0CIluG40j2yTx5sEdms6mkaWs5Lj9
         4uPYN2UIGIHu5mmeWsT2GwEGl678rQoz4AhqDKrNgQDklxRKKvPs+EHkVJbM0FGFmS
         dHcIhcj+GEi7EGVBnTZ6ieqtiH3397Z9X9XgHTxU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.131.179]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lj2XW-1jZg6d0OoI-00dIzo; Tue, 28
 Jan 2020 17:24:53 +0100
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH v9 1/2] fs: New zonefs file system
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Message-ID: <1928f213-f6c8-156f-a968-6d0603a7656c@web.de>
Date:   Tue, 28 Jan 2020 17:24:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F3L4Sg8wKTShzAEVuteP5QIgWQ5qNzSUMXawHy2itbq8+p+oRcd
 BTerA7YNbX9/H6xgQBmQhcNimuKGD55s+Kb1CgxVuVwyoPYqZIKT2Bg4ewIGU8BBaAoabJN
 /otvC7i33lMk8FV8RJIzU9UjnvmMPLUtc68CXwktyJz7ycIchN/WM39i32jZW45uQ00DaVO
 MeHanePewzYxYlUIE/0ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KFn36JFlvnE=:RqeyIl5POgkPWZc6l224tm
 Yk0tzgN0G0KT1Lv+5upqzRJGkBf7x1uLtDROA6miqU0N4733kyk9E9CJ/8InB+gcR7auma5is
 q+nrTgHzwPIdpPWSgX+r+RAnpkwwFus9sxsSylFHVWZvUnYV34SR3n3UrmuHUVoGpbGJmsZNR
 uQVFgOGRwNUzkRI4PBbKFoROhEbRFoHjK6w5MVfVGceUTCJ0Uhki4P4A7rAwQgbazaw7JCVML
 D7RjfrBVvTP3gIkrJSsqNHQLIP3jXCl/wLeSXJFZnx05jcOwbBK/enNz9FbyyHykDa15zZ2FL
 /KUYJTNcEjhH98LvdCgx4BIK8tYk4Rg2aOd82OdE4FkTI/dkcKQd/adecDqDPpjQUzl/sWgqw
 ZClvTod8RiMbN1mx0WGQ5FILur9FG0q4iACqNj+e2npTdPmSpUuWK+xEU3nzhnnYBCx1838Is
 KD3af2mJZg2BDvJiCiB1hEWWhx1kjoTTWq5bqA/CMUQZtsspqVeL/aZ2diOLETW1ptf+FU8s2
 qvSVc2fVkHC/M3mG4IUFmVB02IudIx+OKDkBtxwkpqyP5Zss1zLx2qyyiAryMSDeNxp98dFWy
 Pu0KJSrP41jLV19BwADyuk+s5yY4VE4kDXsL7yAegy90TyEFhZ1J9RD8QfxnJukGWzO06sLk3
 ObxjmICYb9vVcECnVRmuj5QCX0yBEStmTkVU62uwFnQyMQXKZnEy79z/4CvG8hMs0qv95icKP
 PyD0cKv4eFEzsyNAysvYX+XxSffQZLeT798S/UOenwwRgyPyeK/q7N5EpXmrOCXYXSRzPCFu3
 Qf6y/oxSk1oHee2be/l/PWkSuT45UXdfRskP1h4nArTmtepcDjUIAfVQNc7lQisfA/55iTANQ
 BiV2JAy0xBX/6WMn7iNDlXK2luO2X3kdOcjojQvszRuZIhxCLfqbBeMcsXDfqi7YsD4cJyQ6A
 HAU0rE1MZERX2fDmbPgFK1wK+wKZMCZPFSeq+D8ZTIBT5wWQ0O5+rxmhPArotgRc/IZeagvjY
 OZ78y/wSDHcfJ9eq729A3zxWKt9tF6B7teda9pOolYxLO+jhCZ1uwPd+qt+cTHuyMQ5FYcM2P
 ziEzjf7yf4UCT2gyljh/5VuB7Z+hNY3OPJGSzDJnOjCBthkfOlHsz7BhZ4/n0GsFXYu94hXli
 xNQJhj+tIDwl6JJP+eFWvhu20WBAkua9uzH9uro/PE8LU36P9mt1oHIQWcOjhKOAs9mHASjV9
 glXEB8W8Q7hi+jkYk
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/zonefs/Kconfig
=E2=80=A6
> +	help
> +	  zonefs is a simple File System which exposes zones of a zoned block

Does the capitalisation matter here?
Would the spelling =E2=80=9CZonefs is a simple file system which =E2=80=A6=
=E2=80=9D be appropriate?

Regards,
Markus
