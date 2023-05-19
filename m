Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7211C709AD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 17:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjESPDi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 11:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjESPDh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 11:03:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DAE121;
        Fri, 19 May 2023 08:03:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64cfb8d33a5so2431142b3a.2;
        Fri, 19 May 2023 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684508616; x=1687100616;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BBqIfZeDzATL4+pMrzdtV9gMN3jbEz9C3wUVWk3CSQ4=;
        b=aGZAJXm2rY93TQ6c2VS2wwK+xIo7VXU8TtZxHvZ/UBs6wRX2ARMfBS/VQlxEOSGl+o
         feR9Xx6uw4yVxMQGIsaK+6FY87YOM0orwXaF6CnoBciSpI+z188mXto6qy4MdLl6oI+r
         cH2LqTeupFiyN2g6mpC4h/k7f9Q969zn9zIqv28Sez7YhGxi5vjQecOfRaOdrxa2WmoG
         ZrW2JqHyXAckpRI+rY1KzUOtLH89eZsNEaPj/mkaVr9Y4nWlQaTX4ntQnKr2qk7jd4A8
         YEiS6RBVB70BJoAh8KSDxdR3hrSl3PzaeYJJ3xoJgEXu1NiHwvrGaHv/W2mvhcLMQEl/
         wOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684508616; x=1687100616;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBqIfZeDzATL4+pMrzdtV9gMN3jbEz9C3wUVWk3CSQ4=;
        b=Is++3NnPwzm63OtJmRjmgX3DTFcyedSS4fSO7//4mBp6t5Emf/+L9saYsd6kDJwS3o
         JuYVNaWfl0o4bZq11tEZwFVhfoNxF5qkQq9pFuHWwp3rkBGlW1FS6zSbjFS9nzKOoZFG
         aXbmqk+k6G2FwyZ/IXEey1jqJKEN7Dkfzc6rzN5lKkWnS8QsQT0NZymo2pgbWD19IIW1
         +x5HdkmZ4VQpHdQcL1im6B4pG2FwcEoQrSAqEhZoDhaczbTDpQ/E5oLLrVt6ulfTVxvE
         WaPeUayV74I0eVGApYBSonvn+QKYeabarZ0A7VxqFpFY+Bjqo1DwyTEVa9vdu52TwSj4
         0UsQ==
X-Gm-Message-State: AC+VfDzFuiVkLoCuEBRuQ/ttu7oWIT/LRw4jeDRD7X52J038mhXw6+YW
        HM7q1kCuelPykuHsvZ0JXEU=
X-Google-Smtp-Source: ACHHUZ7QbBvICcmApDryp8Bb8qWgpUNfDNhZrrYmg++UgV60HzWN6wJjQmqeAwPYZG1K+bfH8o5NRQ==
X-Received: by 2002:a05:6a20:4315:b0:104:a053:12fb with SMTP id h21-20020a056a20431500b00104a05312fbmr2207874pzk.60.1684508615766;
        Fri, 19 May 2023 08:03:35 -0700 (PDT)
Received: from rh-tp ([49.207.220.159])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7800d000000b0063b5776b073sm3104144pfi.117.2023.05.19.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 08:03:35 -0700 (PDT)
Date:   Fri, 19 May 2023 20:33:29 +0530
Message-Id: <87bkigwegu.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 2/5] iomap: Refactor iop_set_range_uptodate() function
In-Reply-To: <ZGXCw7OHfKQ9TNiW@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> +	if (iop) {
>> +		spin_lock_irqsave(&iop->uptodate_lock, flags);
>> +		bitmap_set(iop->uptodate, first_blk, nr_blks);
>> +		if (bitmap_full(iop->uptodate,
>> +				i_blocks_per_folio(inode, folio)))
>> +			folio_mark_uptodate(folio);
>> +		spin_unlock_irqrestore(&iop->uptodate_lock, flags);
>> +	} else {
>> +		folio_mark_uptodate(folio);
>> +	}
>
> If we did a:
>
> 	if (!iop) {
> 		folio_mark_uptodate(folio);
> 		return;
> 	}
>
> we can remove a leel of identation and keep thing a bit simpler.
> But I can live with either style.

Yup, it pleases my eyes too!! I will change it.

-ritesh
