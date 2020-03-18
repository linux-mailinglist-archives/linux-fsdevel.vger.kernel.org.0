Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A67318943B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 04:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCRDBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 23:01:24 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41521 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRDBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:01:23 -0400
Received: by mail-qk1-f196.google.com with SMTP id s11so25123141qks.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2020 20:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ydkM02gA1lv2jXZ+vVnjGn/g5VzXdwCSm+r9ur1CJPs=;
        b=IHTT0YwYPoS8iMmX0qpmgTqBgRe4WcF01YbL2TEUEwWqZdjOAZwHvbArCyepsxfcs0
         5RhcvvUs+1Nhtw8Q6FHiVx6OPM4knOtgscqJG4CCaIjYfENTn8BQGSfU8HnjNQ0Au5q5
         fCJ1bE1qbheMPOHu5Rx+kKtWBcbtX1E1cUtDYKEmYlLrkxgQNFYTrzM5p90radr5v1Do
         uKvdEWktYiutwnbjOklODkdp0T+wqHzG0jkZ1uC+yH67D/mYvJ0vRtYBv6vLNZnQN5rh
         lsF+ZTSX4PkQQneVutZwIkM59OL6A9ALmdJbMV/E2fIKiRfxHbcRzHn0n78WLUHNuXvy
         MMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ydkM02gA1lv2jXZ+vVnjGn/g5VzXdwCSm+r9ur1CJPs=;
        b=k+txT/7guvAQhD8jvIocjVvd+QCG0wxetrdRgnKqcha3Pbmr5K4tOmvFBgtnBm21f5
         tfVsSPXLhAEnle2+2jcL9GTAAYNfRfpG8986ChrsT4OPMk7P0G+RAt+9lHF3oHCKT+1f
         OL0qe2OVssm1DQEt3mpLUZXAdJ6bxuXYHMgePmjLGl+C7otesvs/WeHmV5eeQyIBOx01
         Bz0FVHy4fMYEvXfP1CHBKGIyrCqQlAcpwvQ5aJIh1bp0TFGFPHJlMgOqrUqbp5Cfz/GQ
         BwiKa1SvutXvjGgckidl1W6qLdenSKmyxzFY+SkGuOo7esC3ap4w4p/DTdBdAClTCtk9
         YbKA==
X-Gm-Message-State: ANhLgQ367XkKIjt9sBpTfJjysB6JPJRW1AOwKZHziZTMC60Xq7EYIt/C
        rWM+9gLaHDAwkrGyaCtOatnLoQ==
X-Google-Smtp-Source: ADFU+vvoBQmPUjD+nO2M86aMQl7VYth980jIKigj6jVHrMsul9eZMS8ExL6RHyTxp/EV9PKXlpRWrQ==
X-Received: by 2002:a37:6244:: with SMTP id w65mr2061863qkb.350.1584500480945;
        Tue, 17 Mar 2020 20:01:20 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id i4sm3478217qtr.41.2020.03.17.20.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 20:01:20 -0700 (PDT)
Message-ID: <3ffd63b480b47aa572a9f95ba620eb4d0ce93f34.camel@massaru.org>
Subject: Re: [PATCH 2/2] xarray: Add missing blank line after declaration
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Date:   Wed, 18 Mar 2020 00:01:17 -0300
In-Reply-To: <20200318015553.GG22433@bombadil.infradead.org>
References: <cover.1584494902.git.vitor@massaru.org>
         <7efa62f727eb176341fc0cdfcd47c890ff424451.1584494902.git.vitor@massaru.org>
         <20200318015553.GG22433@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Tue, 2020-03-17 at 18:55 -0700, Matthew Wilcox wrote:
> On Tue, Mar 17, 2020 at 10:43:03PM -0300, Vitor Massaru Iha wrote:
> > @@ -1624,6 +1624,7 @@ static inline unsigned int
> > xas_find_chunk(struct xa_state *xas, bool advance,
> >  	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
> >  		if (offset < XA_CHUNK_SIZE) {
> >  			unsigned long data = *addr & (~0UL << offset);
> > +
> >  			if (data)
> >  				return __ffs(data);
> >  		}
> 
> Do you seriously think this makes the function in any way more
> legible?

Sorry. I was in doubt whether it would actually improve. I did some
research in older patches and I found something like this.



