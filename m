Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 209DBE41A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 04:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbfJYCjJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 22:39:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbfJYCjJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sVL72IEnASGUFIun+CE72v94BxJjKdJ1NDcm7LwViSw=; b=dL3ngCsLRac53SA2YNqk+ZHSH5
        /c+2xQjru/wv3o1K9PFWtdRc+BJWDT9L7Fm9GRiDQAvV8vRB45MnBE750UHjij1PwEf5tBSG6e2l6
        /Tg+3oFNXeFsCALow9InwXg4UdprbSzoxL9wjNSbCrnjbAmFmgmARliJ5PP9Jt0n/5Lce4uHz3Jyw
        CiSgP7n/s3xVb/xPTWpl4uXywI0WOyvsRKTMCzYi1sYssZ9fSAOxRKrbVtReTgSMO3XPm5SSlBtRO
        lMWsTttycMSw5WoLF9mldBrdK2PQgzz2zsjxcXDnBh3fA7M1eejwnHXPwp/77YQh95XZdnWeMrKi/
        ZuW4lIFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNpVM-0003py-Ui; Fri, 25 Oct 2019 02:39:08 +0000
Date:   Thu, 24 Oct 2019 19:39:08 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] cdrom: factor out common open_for_* code
Message-ID: <20191025023908.GB14108@infradead.org>
References: <cover.1571834862.git.msuchanek@suse.de>
 <da032629db4a770a5f98ff400b91b44873cbdf46.1571834862.git.msuchanek@suse.de>
 <20191024021958.GA11485@infradead.org>
 <20191024085014.GF938@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024085014.GF938@kitsune.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:50:14AM +0200, Michal Suchánek wrote:
> Then I will get complaints I do unrelated changes and it's hard to
> review. The code gets removed later anyway.

If you refactor you you pretty much have a card blanche for the
refactored code and the direct surroundings.
