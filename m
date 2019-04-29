Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07E51E214
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 14:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbfD2MRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 08:17:23 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59524 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727936AbfD2MRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:17:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5EBF28EE1D8;
        Mon, 29 Apr 2019 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556540242;
        bh=V8W4i17PSPDCdFQgaQ9datYSRuZ6HJF8DVD1l4ouvDk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ogISHwwqWQR46xjt+1BXFuVlmD/ievw37QJxSJbIs+glnx90FnZ+stHg6eYqOk1Xb
         rctKlGG5rAmGXfePLpiFcA27yJVAbeN8WjUk0pFm101/zHrbYEZ66fEW7yidn5un9H
         TclnOUVVeIjNrhPBHgoz44MCM1/Pyu/9mzlGebfc=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eMNwNV-9nJIS; Mon, 29 Apr 2019 05:17:22 -0700 (PDT)
Received: from [192.168.100.227] (unknown [24.246.103.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 534438EE03B;
        Mon, 29 Apr 2019 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556540242;
        bh=V8W4i17PSPDCdFQgaQ9datYSRuZ6HJF8DVD1l4ouvDk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ogISHwwqWQR46xjt+1BXFuVlmD/ievw37QJxSJbIs+glnx90FnZ+stHg6eYqOk1Xb
         rctKlGG5rAmGXfePLpiFcA27yJVAbeN8WjUk0pFm101/zHrbYEZ66fEW7yidn5un9H
         TclnOUVVeIjNrhPBHgoz44MCM1/Pyu/9mzlGebfc=
Message-ID: <1556540228.3119.10.camel@HansenPartnership.com>
Subject: Re: [Lsf] [LSF/MM] Preliminary agenda ? Anyone ... anyone ? Bueller
 ?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lsf@lists.linux-foundation.org,
        linux-mm@kvack.org, Jerome Glisse <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>
Date:   Mon, 29 Apr 2019 08:17:08 -0400
In-Reply-To: <yq1zho911sg.fsf@oracle.com>
References: <20190425200012.GA6391@redhat.com>
         <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
         <503ba1f9-ad78-561a-9614-1dcb139439a6@suse.cz> <yq1v9yx2inc.fsf@oracle.com>
         <1556537518.3119.6.camel@HansenPartnership.com>
         <yq1zho911sg.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-04-29 at 07:36 -0400, Martin K. Petersen wrote:
> James,
> 
> > Next year, simply expand the blurb to "sponsors, partners and
> > attendees" to make it more clear ... or better yet separate them so
> > people can opt out of partner spam and still be on the attendee
> > list.
> 
> We already made a note that we need an "opt-in to be on the attendee
> list" as part of the registration process next year. That's how other
> conferences go about it...

But for this year, I'd just assume the "event partners" checkbox covers
publication of attendee data to attendees, because if you assume the
opposite, since you've asked no additional permission of your speakers
either, that would make publishing the agenda a GDPR violation.

James

