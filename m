Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC81997B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 15:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgCaNk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 09:40:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32995 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbgCaNk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:40:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so26051926wrd.0;
        Tue, 31 Mar 2020 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/9EBLsEVdQd7BkOtwGcu2A+J/8+N6QWVnG9D8e7od0M=;
        b=Z4pm9+43OQMQ6wPQx3hcVAmJKO4eQWoLgN0mN01kAC4wEmCM75Ib/Y1iQdgVnufnPK
         ChnyW7D1c+M1SipJ/qk1kxVqz+pzOiI9+y3ueuHZ93STWnkqnoEE1Yd3zmbiHojnKkMu
         B6gy1kWGVxyInzD2qwfqhWlGCyx8t6TNxieUWyrNYW9ypEzfKF4345Pq08EeE66fULQc
         rvY0dv0v1saRmts2cWUCwYiMk3056rNt5KzHF5KQpTS3XQh8BAifgXMtcqTRV6Ao0oBk
         qxEw89nPLdNUGaCxnQo8dR/acFZDc0IJ087mipHVBwHlNMeyXr5Js8TYf/xTngz285Do
         40hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/9EBLsEVdQd7BkOtwGcu2A+J/8+N6QWVnG9D8e7od0M=;
        b=Pq01kmiNuLsp3Wv2sjCbB1ee+uzRpOWCXOK7zuym8l4xxKOvClgOnDHiGVUrZ34nAY
         egYU2MmvfuCjV31UEHpFg3xJdiJd5dklPnUkKKZNsWT8A/xi/qGEq7s7X5G9RcaDo40G
         4TwTBQNbouw9D03qn57V36OTbYXKAUJubaZ2Miu6TJGjQM+1bhZnuw8yBSzgJCagie7B
         pTjGlhIONe/1GctINmyaiDPVm/SjcbDgId7Eewh6WUCWjXxYCVgSh5bKTKCc7ERHLxe3
         MsvLjGkvqEl3am6OvOBc9/gUQ63bputpB+TAllqxDHC1MEyD2SpbDSz1GRwEcGuf3uzY
         Mo2A==
X-Gm-Message-State: ANhLgQ0BhVE3rWJ3PQcN8sYTmhTuCXIAL5W8pdHU56cBPNFR1MLi//sI
        3/xw73N+X1TAg/5ZPCWYOf0=
X-Google-Smtp-Source: ADFU+vv/+83E/R4QRbX3VtDC3JObIjDIHUKnP6E+i30VA7ZF/7O6PARVZN/MafwHZ+8o8pc2LujPMA==
X-Received: by 2002:adf:b35d:: with SMTP id k29mr21052741wrd.239.1585662024316;
        Tue, 31 Mar 2020 06:40:24 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d21sm27844585wrb.51.2020.03.31.06.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 06:40:21 -0700 (PDT)
Date:   Tue, 31 Mar 2020 13:40:21 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] XArray: internal node is a xa_node when it is bigger
 than XA_ZERO_ENTRY
Message-ID: <20200331134020.xejcx3mggobmzmji@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-7-richard.weiyang@gmail.com>
 <20200330125006.GZ22483@bombadil.infradead.org>
 <20200330134519.ykdtqwqxjazqy3jm@master>
 <20200330134903.GB22483@bombadil.infradead.org>
 <20200330141350.ey77odenrbvixotb@master>
 <20200330142708.GC22483@bombadil.infradead.org>
 <20200330222013.34nkqen2agujhd6j@master>
 <20200331000649.GG22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331000649.GG22483@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 30, 2020 at 05:06:49PM -0700, Matthew Wilcox wrote:
>On Mon, Mar 30, 2020 at 10:20:13PM +0000, Wei Yang wrote:
>> On Mon, Mar 30, 2020 at 07:27:08AM -0700, Matthew Wilcox wrote:
>> >On Mon, Mar 30, 2020 at 02:13:50PM +0000, Wei Yang wrote:
>> >> On Mon, Mar 30, 2020 at 06:49:03AM -0700, Matthew Wilcox wrote:
>> >> >On Mon, Mar 30, 2020 at 01:45:19PM +0000, Wei Yang wrote:
>> >> >> On Mon, Mar 30, 2020 at 05:50:06AM -0700, Matthew Wilcox wrote:
>> >> >> >On Mon, Mar 30, 2020 at 12:36:40PM +0000, Wei Yang wrote:
>> >> >> >> As the comment mentioned, we reserved several ranges of internal node
>> >> >> >> for tree maintenance, 0-62, 256, 257. This means a node bigger than
>> >> >> >> XA_ZERO_ENTRY is a normal node.
>> >> >> >> 
>> >> >> >> The checked on XA_ZERO_ENTRY seems to be more meaningful.
>> >> >> >
>> >> >> >257-1023 are also reserved, they just aren't used yet.  XA_ZERO_ENTRY
>> >> >> >is not guaranteed to be the largest reserved entry.
>> >> >> 
>> >> >> Then why we choose 4096?
>> >> >
>> >> >Because 4096 is the smallest page size supported by Linux, so we're
>> >> >guaranteed that anything less than 4096 is not a valid pointer.
>> >> 
>> 
>> So you want to say, the 4096 makes sure XArray will not store an address in
>> first page? If this is the case, I have two suggestions:
>> 
>>   * use PAGE_SIZE would be more verbose?
>
>But also incorrect, because it'll be different on different architectures.
>It's 4096.  That's all.
>
>>   * a node is an internal entry, do we need to compare with xa_mk_internal()
>>     instead?
>
>No.  4096 is better because it's a number which is easily expressible in
>many CPU instruction sets.  4094 is much less likely to be an easy number
>to encode.
>
>> >(it is slightly out of date; the XArray actually supports storing unaligned
>> >pointers now, but that's not relevant to this discussion)
>> 
>> Ok, maybe this document need to update.
>
>Did you want to send a patch?

I am not clear how it supports unaligned pointers. So maybe not now.

Actually, I still not get the point between page size and valid pointer. Why a
valid pointer couldn't be less than 4096? The first page in address space is
handled differently? Maybe I miss some point. I'd appreciate it if you'd share
some light.

Thanks
-- 
Wei Yang
Help you, Help me
