Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E842314D752
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 09:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgA3IKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 03:10:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgA3IKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SEQYndPiQmHOinSK+5y0b6xfiS41LxvS+Ygq8GPrsz0=; b=Woj0I4jnSm3FzQbmUq6+phIAE
        VpS2wAWZ6qzBTSiA6+KJLJeZ9IJQo1IqzfIFbO9F9U013MkZDuBKnAfT5OB68HV2xbY5/kB+RHbVE
        E8P7HSQNZWfZIyY8SuKKokFMl/gRwea6+t3lTcWic2MCWwljy7u9IP7KvM4SleQbf9WV0h7SBx0/r
        RlsnXkgBCOBUo60U2z1I/x5z8+WOFcrYrEUkrqxsd9ZAOBPILh+nkp14gflmaQYWVuhu3TkQ+OemW
        SXh8xd/27OU7EMzKIdB6M87ZCaFb7NYahHbS5SggQfDRIrmHZsY8eK4pkWy+xMjY0X27qIaQ+6ixP
        5RWDLmRFA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ix4uZ-0000RV-KY; Thu, 30 Jan 2020 08:10:51 +0000
Date:   Thu, 30 Jan 2020 00:10:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 07/12] erofs: Convert uncompressed files from readpages
 to readahead
Message-ID: <20200130081051.GM6615@bombadil.infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
 <20200125013553.24899-8-willy@infradead.org>
 <20200129005741.GJ18610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129005741.GJ18610@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:57:41AM +1100, Dave Chinner wrote:
> > +			bio = NULL;
> > +			put_page(page);
> >  		}
> >  
> > -		/* pages could still be locked */
> >  		put_page(page);
> 
> A double put_page() on error?

Yup, already fixed when Gao Xiang pointed it out ;-)
