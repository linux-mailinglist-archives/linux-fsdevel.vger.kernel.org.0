Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 484CFE158
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 13:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfD2LcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 07:32:18 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58622 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727846AbfD2LcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:32:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 02B9A8EE22B;
        Mon, 29 Apr 2019 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556537538;
        bh=2iZtI0VfLKpV5ObRkGVTpE3g4x9tbWBVvjAs7KDcmSg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DcoPWb0p2NZ40MoDPNrf3ci9S9jsAy/NUbXb5d5odKyojCic8qw5oGZ5rdYCavvdp
         yZDWqj3sA5kvj17oQq4vXreyHDIa935b/sEjIaXp8SeqcGdXCHo6o+pRJV6WyPWGWP
         Rxrm7sI7f7OxXXoXKPBP1us/9a6WvuLNuVebB8rk=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id K-7FVscySGeW; Mon, 29 Apr 2019 04:32:17 -0700 (PDT)
Received: from [192.168.100.227] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C338E8EE03B;
        Mon, 29 Apr 2019 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556537537;
        bh=2iZtI0VfLKpV5ObRkGVTpE3g4x9tbWBVvjAs7KDcmSg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qUwpVC0QJuutvZlqdtgObuMf5BV9POiAAXyZCN9P2HmjcRGX8+KOi8BLr/4oZo/+S
         qHplN5NkWkxuuOmvHzNKiHFHdR2/CjbL851psO4zifniklhjbFcZMLINdzL0eLebm1
         3T8oJrams382HTXWYrPU4VoMYP79BEswcW7wv2L8=
Message-ID: <1556537518.3119.6.camel@HansenPartnership.com>
Subject: Re: [Lsf] [LSF/MM] Preliminary agenda ? Anyone ... anyone ? Bueller
 ?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, lsf@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org
Date:   Mon, 29 Apr 2019 07:31:58 -0400
In-Reply-To: <yq1v9yx2inc.fsf@oracle.com>
References: <20190425200012.GA6391@redhat.com>
         <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
         <503ba1f9-ad78-561a-9614-1dcb139439a6@suse.cz> <yq1v9yx2inc.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-04-29 at 06:46 -0400, Martin K. Petersen wrote:
> Vlastimil,
> 
> > In previous years years there also used to be an attendee list,
> > which is now an empty tab. Is that intentional due to GDPR?
> 
> Yes.

Actually, GDPR doesn't require this.  What it requires is informed
consent and legitimate purpose (and since LSF/MM usually publishes the
attendee list for attendee co-ordination, that's a legitimate purpose).
 If you look at the LF form you filled in, you already gave "informed
consent": it was the "receive email from sponsors or partners".  That's
an agreement to share your email address.  This is also sufficient
consent to share with attendees since they're also "event partners".

Next year, simply expand the blurb to "sponsors, partners and
attendees" to make it more clear ... or better yet separate them so
people can opt out of partner spam and still be on the attendee list.

James

