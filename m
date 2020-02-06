Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB1154C8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 21:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBFUBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 15:01:14 -0500
Received: from mout.web.de ([212.227.17.12]:35751 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgBFUBN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1581018967;
        bh=sHKBRtQ5MMP2lH0vSAPW5YT6SRR+Pv+IgL7Kc7G1Ewo=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=Jtajd38xKe6rPo8vletnh/a1BKPBJ0JO73QAgAHtSWlkmdxm+leJd81FaVFfcqxjD
         LKv9dgaRXTE3JBobkLNhEpxukqAjEuuD5RlztgaoGdiVdxexMrGEFql+sLJ4ITvsJD
         99RtZy0jtPJS4PlD9OfAWiusGAmEB3m1XhZF5ilI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.144.33]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxwiW-1jcL3L04G4-015Igw; Thu, 06
 Feb 2020 20:56:07 +0100
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v12 1/2] fs: New zonefs file system
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <02780281-ddb3-7a2f-b5af-cc317d4adf45@web.de>
Date:   Thu, 6 Feb 2020 20:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xktzqL4FDMyeaTEy+oFlihkYsBuy+Ea4Ed64HAB3NiJPxts4Fj3
 kuH3USFWB5DkhIWu+7/e05vcrdtEaVDeaAcXbzzfLuKpuM8KpQfkbqrOH4gfZQstmZzxYsm
 +ki4nFnupmKy9qAJdnQ/X3czcjDy/uQ2zgNVTgzEV+muHsIEEvGuLb5teqJDO4W+0bQPHfY
 onCShYRJSN0hCOgF3BRrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:c7uh7dJU3uE=:iMcluD0RsxPnh5UrdqUA1w
 8WBCk84kOjiErBkY3ZbV+SEMoAEPjOU7kvw1981cCtBO8pEKlMvSfWxAhEPVdP+4HJKo0oaTw
 l2PReHyUZ0RKFNDGj/OlFoF5PuAvMN9YsJbF90qptuEuHO7X3aeYmS+rrInc8L/RXwQstUOBF
 wslVNDoFOpfOOZPbfW6hW1xS754XvcIx5yDaKaF1bWdNM+zW8pWg0Cgy3/zGsYIYTUe0uMFcG
 EYRO2/W5w4JvP6TQb3EEJqGjyHHu5qdEuiP2OftCzT+bdvBCWNEIEdx7Wl/hpyTi6c0+gGXaI
 1Bz6pYS8GWskD9c076jnKdLcFW9gNB8pghV3jyAtTD9jWYeeCKB9GYZG8ZBOsLTti8eM3Fu3c
 BxSolysBWmImC1t3Ek4ykNyxCjxewG8y9QwI14lHF57BwHoZuva5JcKEMNuE5gksSIYZWPbWc
 snU/9s7rAPTlz/YxDEy4Vi6WS2RLbBrCr/OQrKvK0oI1Wt3FWI3qh8HNpiIXdhkUoZ/2xo2pR
 l8REgO4IxK2VTwqxr2GWPng22L5c4ANbdNx+RoQ6utUVGgQ7s1IKGU7YRcfGqgz23t/uRqtIg
 HRjFtTuXVQlO24tSA+SpOKskgqa9juseyVQJh7NAeX6zP+KGhWRhCUiYVC/bn/f8Rjhi0qrqf
 3l9K8P8CyJ7HdzNX32ZbZtDquKBlU/z8WhSlEv60i9C6zVJHpcOrda2C4REoSGe7POID5sfRK
 SJzfZPms4UhwhyWYwSlL4fDdwkiKL9iQUazqhESe/SaVZFpRPbMpAKypQhywwKrsYp8LIK9Tl
 la4Sqj4z4h9y4+qwduP1rRJYg9ZkOVGoH2Uj02ed5RBrJG0DKX1CSq4SYx1kt7GZdEnwwOstO
 JK8xidhA/aXVD2WrCO/PoDT/xZQJp5HDXW6+knivPNWCGJ1/08sp+KiQnqYv/5OdfLhKq5vEY
 faD4eUQAZRxg2rojIwnOC2XOf3g7PrUIsPGa4Eiozb16qtqrf38LWaNzxq4Qsd8WtWglHam1X
 kHCdv4TL7hSB+jk7li+Rj5LlKmYupGoilhJcPMGgZ31e2jSuUT1pWB2Gxmz1F6Zi7NUmPJE/I
 4qBgvNXSjGvZ+kR9eJuJZKDBs13VhUCOIJN05EKDDS1FvXvN3vdNEep/L4DBh7Kpj0Y1I4yXq
 acIqxjbVCKhH8OtcyPl0gfs6ExYh9TrLey/goBTnqgd5T6p4tUuI7MI0tu35niilhd+lqkSTg
 lvv6eYd9/G7Bzo0tF
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> zonefs is a very simple file system =E2=80=A6

How do you think about to be consistent with the capitalisation
at the beginning of such sentences?
https://lore.kernel.org/linux-fsdevel/20200206052631.111586-1-damien.lemoa=
l@wdc.com/


=E2=80=A6
> +++ b/fs/zonefs/super.c
=E2=80=A6
> +static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
> +				enum zonefs_ztype type)
> +{
=E2=80=A6
> +	if (type =3D=3D ZONEFS_ZTYPE_CNV)
> +		zgroup_name =3D "cnv";
> +	else
> +		zgroup_name =3D "seq";

I find the following code variant more succinct.

+	zgroup_name =3D (type =3D=3D ZONEFS_ZTYPE_CNV) ? "cnv" : "seq";


Regards,
Markus
