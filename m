Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55229FD6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfD3QEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 12:04:09 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:42395 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3QEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:04:09 -0400
Received: by mail-qt1-f169.google.com with SMTP id p20so16739788qtc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7C/H9ZzSU0qP8UYq2NJoxOTSjxthMtozx8jthqagPTo=;
        b=V17+lfAqUPk01IFJXUO56hClBUX2HDbxSbQULpTYSKkdi7HyAd33jfH5SIR8cXdcvE
         hw/F9aMeFlPeuK5f4rBww/6N/Xmuv3823rpt63eVEiC0Qan/UjihZuDkm9RygVdZFQS+
         uDXcBV7siz7kiet+/qLVaIcLptgJ9iivk9KSHlfQPKEm/K6sK09PpdfaQ642KUtpoLIG
         Ei/9gzhfAHqdmqH0fjfZyrt7AVGrIzU5C9CHggarLYx36WwDp5F8075K02Wntqlwb84c
         HpvByXvkJ7w/RAav80V4R5dscpV10nEf8hg1TH2pyWT4QZjAgYqwSCLSFK5QFiXIrs9J
         nWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7C/H9ZzSU0qP8UYq2NJoxOTSjxthMtozx8jthqagPTo=;
        b=GDTDUr3mmMh7RXevVGlOu6V1CNRQ7aijEH5jdaK74kj+oJ1Zu6YFs6znvXYOrJg/pC
         KJPkHY63kiD/9n9oUeYklybrAz6Q+O/mleEwICJK+sGdK5tZGFHwKXgVLHVxttfH6AKS
         RPLnCbvXr5bn/+GameaXmT2Ezwono4Wsp4OqVUYGDN9iwlOxqFGRZKojEjuSrtRvqO5S
         FIkNyuLqUk+g37d9AiONffsci5o6gUmI+XUsU84qcBt1AWgKnRKQPhIJwXXLU+APp1y6
         UhdBd9DA24pQhbG5bO0VpXV9kFZFvvqViuAxWvOiPO+yHVPDgfhaVyA2tAimB4mlq19h
         IwZA==
X-Gm-Message-State: APjAAAXXIpLMgRA8ecSH8uUjvPYGY0QLxl38TDTQPDVCeMtrISPWpXVg
        kqfmVGAHJBd/b6G69OywBth9PFwMIFCZDmADZdHD
X-Google-Smtp-Source: APXvYqwcvQfk6RKX1YA+CEknGA6KPVffr8HcdjX65JCcNo0SBSztv0+v1lrmNaDd0LojAXwHvRQTc8ngINVBxL3bMxI=
X-Received: by 2002:a0c:ae17:: with SMTP id y23mr31197725qvc.199.1556640247675;
 Tue, 30 Apr 2019 09:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190425200012.GA6391@redhat.com> <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
 <503ba1f9-ad78-561a-9614-1dcb139439a6@suse.cz> <yq1v9yx2inc.fsf@oracle.com>
 <1556537518.3119.6.camel@HansenPartnership.com> <yq1zho911sg.fsf@oracle.com>
In-Reply-To: <yq1zho911sg.fsf@oracle.com>
From:   Jonathan Adams <jwadams@google.com>
Date:   Tue, 30 Apr 2019 12:03:31 -0400
Message-ID: <CA+VK+GP2R=6+GQJHX9+d6jnMWgK8i1_H5FiHdeUe3CGZZ5-86g@mail.gmail.com>
Subject: Re: [Lsf] [LSF/MM] Preliminary agenda ? Anyone ... anyone ? Bueller ?
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        lsf@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        Jerome Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 7:36 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> James,
>
> > Next year, simply expand the blurb to "sponsors, partners and
> > attendees" to make it more clear ... or better yet separate them so
> > people can opt out of partner spam and still be on the attendee list.
>
> We already made a note that we need an "opt-in to be on the attendee
> list" as part of the registration process next year. That's how other
> conferences go about it...

But there was an explicit checkbox to being on the attendance list in
the registration form, on the second page:

By submitting this registration you consent to The Linux=E2=80=99s
Foundation=E2=80=99s communication with you with respect to the event or
services to which this registration pertains.
* The Linux Foundation Communications ...
* Sponsor Communications    ...
* Attendee Directory
     By checking here, you opt-in to being listed in the event=E2=80=99s
online attendee directory. Some of your registration data will be made
available to other event attendees in the directory (name, title,
company name only)

Why isn't that sufficient?

Cheers,
- jonathan
