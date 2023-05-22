Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CCF70B3FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 06:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjEVEFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 00:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjEVEFN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 00:05:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D011DCE;
        Sun, 21 May 2023 21:05:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae5dc9eac4so33584365ad.1;
        Sun, 21 May 2023 21:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684728312; x=1687320312;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZEQ5yBCiiO4UXJi5xv3qcBZvIyrMZ7SI/fkdtyHWJOc=;
        b=RIU/Xg+iDKBtlaP18TZP8zCzE6uQFFWvfdM7G3LwbdhBcYW0ZBsy/SCz0uYVhrxNDq
         /fdN7w4zSZOvd5vnXDTHlgHtPmxMVirsXai5lt5NKaOxbG8+1gE7lI4E8NqP/ejyFa44
         vPr5J+YXkE4Sk1fihAa2eOTVwLTVQk8yAs4NVlWjrMN1ZJpE19c8jNcWezHxitLN3iQr
         1F/15vdtyuGcLknvrdkZPoCqYOLP+Z7PYv11lI7kq6aJIObssq7zVvFXpV+QuDeRo4N2
         eNhBOfmURqeMCdNN1Qu9GnuknJa1IYgdox4Dapy0ohkPnO7C2jxYOJWN6ldkd7N+CYfu
         xebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684728312; x=1687320312;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEQ5yBCiiO4UXJi5xv3qcBZvIyrMZ7SI/fkdtyHWJOc=;
        b=cUUl1g3/CfgRo338VgAFyYLWTL3LbQ9pGFmKs1Nq/09+WLA8khBH6tsugA9jR6D8tY
         ghcDsPEJmqP2snw0RR+eOUk/kr/zTzNFvcuo+HKWR1+TnNBIpPgABBfGV5CChmyLgEtb
         MsGnMuP8XljuNYbj6PAmm3KNczawzWauR8y3v7BpBVzoI7YCEttk1aJQI3qsi5lubZeK
         6rTYZS6hHsWthNEcgeIk98k7jbyeGyyAPhETgQlfeGgkWD3uisTJOjKcU8AzqnqG8Jsq
         VpTWlz7VQXkPuplyDqKmaPkJOjq3jHHvmUaRoEzw5N2RsZ7CzTpELjq+r+o0uUSVCISq
         idsg==
X-Gm-Message-State: AC+VfDwMzDc9yYsC8TlHY9YY1Te9mxXsAqU2TQvF2gAhC3D2U1yqpsV3
        foqsYD0CQ/y+WkIQENTbNzM=
X-Google-Smtp-Source: ACHHUZ4HPui9A3YRhgM3wn26DBFPD1cAsibv/t4QWpVIm2tKBjOcyzFcRH65cgiy+pb2sweNMn40Xw==
X-Received: by 2002:a17:903:32c3:b0:1ab:8f4:af2b with SMTP id i3-20020a17090332c300b001ab08f4af2bmr11012341plr.38.1684728312027;
        Sun, 21 May 2023 21:05:12 -0700 (PDT)
Received: from rh-tp ([129.41.58.16])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902ee4100b001ab25a19cfbsm3663295plo.139.2023.05.21.21.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:05:11 -0700 (PDT)
Date:   Mon, 22 May 2023 09:35:01 +0530
Message-Id: <87zg5xui36.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv5 4/5] iomap: Allocate iop in ->write_begin() early
In-Reply-To: <ZGebgckh3oSvQSEt@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Fri, May 19, 2023 at 08:48:37PM +0530, Ritesh Harjani wrote:
>> Christoph Hellwig <hch@infradead.org> writes:
>>
>> > On Mon, May 08, 2023 at 12:57:59AM +0530, Ritesh Harjani (IBM) wrote:
>> >> Earlier when the folio is uptodate, we only allocate iop at writeback
>> >
>> > s/Earlier/Currently/ ?
>> >
>> >> time (in iomap_writepage_map()). This is ok until now, but when we are
>> >> going to add support for per-block dirty state bitmap in iop, this
>> >> could cause some performance degradation. The reason is that if we don't
>> >> allocate iop during ->write_begin(), then we will never mark the
>> >> necessary dirty bits in ->write_end() call. And we will have to mark all
>> >> the bits as dirty at the writeback time, that could cause the same write
>> >> amplification and performance problems as it is now.
>> >>
>> >> However, for all the writes with (pos, len) which completely overlaps
>> >> the given folio, there is no need to allocate an iop during
>> >> ->write_begin(). So skip those cases.
>> >
>> > This reads a bit backwards, I'd suggest to mention early
>> > allocation only happens for sub-page writes before going into the
>> > details.
>> >
>>
>> sub-page is a bit confusing here. Because we can have a large folio too
>> with blocks within that folio. So we decided to go with per-block
>> terminology [1].
>>
>> [1]: https://lore.kernel.org/linux-xfs/ZFR%2FGuVca5nFlLYF@casper.infradead.org/
>>
>> I am guessing you would like to me to re-write the above para. Is this better?
>>
>> "We dont need to allocate an iop in ->write_begin() for writes where the
>> position and length completely overlap with the given folio.
>> Therefore, such cases are skipped."
>
> ... and reorder that paragraph to be first.

Sure.

-ritesh
