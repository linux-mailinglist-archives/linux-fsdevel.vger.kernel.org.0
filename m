Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A4A1051D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 12:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKULvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 06:51:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfKULvn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:51:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C172620872;
        Thu, 21 Nov 2019 11:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574337103;
        bh=l6zL6Gy4RcSUr2FRLgzwZG7nNL1nY+sRlIxH1Xba0YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x8fBeXkKMJjXkXlxU9qI2rNTNyon+xmHKCvIk72FP0zK4qkcN+aki0zqgy4OUhCld
         1A/ac/mPVzxi+MllSk4kwRPXrsYfZkwZpRp3k4qWZa4rxLEvBhgcSjizfK6WR5GZD8
         PixI4hW5dsLhIXdRXkVbs6uOYgbsCeF1gqp/o99U=
Date:   Thu, 21 Nov 2019 12:51:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [PATCH v4 03/13] exfat: add inode operations
Message-ID: <20191121115140.GB427938@kroah.com>
References: <20191121052618.31117-1-namjae.jeon@samsung.com>
 <CGME20191121052916epcas1p3f00c8e510eb53f53f4e082848bd325d0@epcas1p3.samsung.com>
 <20191121052618.31117-4-namjae.jeon@samsung.com>
 <38716ae8-a056-4ee3-285a-a3c1ac8307a5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38716ae8-a056-4ee3-285a-a3c1ac8307a5@web.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 21, 2019 at 11:40:28AM +0100, Markus Elfring wrote:
> > +	if (err) {
> > +		if (err != -ENOSPC)
> > +			return -EIO;
> > +		return err;
> > +	}
> 
> Can such source code become more succinct?
> 
> +	if (err)
> +		return err != -ENOSPC ? -EIO : err;

No, the original is best here.  Never use ? : if you can ever help it.

