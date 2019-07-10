Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EB64F51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 01:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfGJXmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 19:42:39 -0400
Received: from sonic303-21.consmr.mail.ir2.yahoo.com ([77.238.178.202]:36735
        "EHLO sonic303-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbfGJXmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1562802156; bh=dk97VOnEirqZGW/C4jJZaUVdSBxy5Zj+0GzwIPvKK30=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=NWn4mMA7TRvb2AsUI6USWmjL+jWMNY8SqXPCPB0Zmdx1gPg1zll4t29tc1oNPXsyhhe2gwAujgi9pD6oa3djsb/wbjN4www/vlwUFTA7C3i8XhqeFJ71zQgVSClmPa5o3VnSm1VBoGz8tjT8TV0VfcazeSyrajNUNL3fiMTDV7EY7qvFc2dEQ6GZw85WPJ6/zhqS3gNX6Fw2CXHoJNokY+mkwEbKHXO5OvNBMSHVh9JICdDzbmzD7QvKmMEFe1Lt9E3xPZnO+CjluBqHOeBR2lxJIK/MQZ+g+GHaKpz6ZaxJkyDlAYE0UbsAU/JIYgeEYO1cNIESs/Qhd+G3WrHbAg==
X-YMail-OSG: E3F8to0VM1lxsh9FADTaRfvpLst1eRzWVhrH9QDugxBepJ04eijm0ZXK2CQjq_z
 d3J5gTj6JVk93_wRbN4ZvIquLkVgCq0Uac4N2w7NV082cSbr6sz1GBRIofvl0ZSK1C8fKPsWhSV4
 bbBvnWiV4Y315tKvAxulQL9klAarfYafa8XGnzJMwqWzRggrM1Pe7yEfAHghy6dYYTOORhEuSDO.
 A30ELrUL67WOdUbA00HhBanaUN0cyCpc0i65Td.71IZGm6t9qjbO5HMIz2Z.bTAiU0tNi77MSBSA
 bQs4_VVnQbxhs0m5PCYf8TgqDTUg58oEZTpddrzTrmdoxiFhAWzn42gOwpgIV0pwJL.q9Ta.iBNd
 09zxBa.fg98h2zyrjc3VtKef1LbJhMTHzK74zE8swopH7KNyPaXzd6qKgkcwPAdXxJrlJibcEcBc
 Jbnsel8_iXN0c3ZeCXJgDxKhC4eQPt9MN0TedlzcYR7ezt51Q2lVZaRlyMcx81ikxn1KfhsUSLR7
 QDRyQQ4i6rrdgYWYBkB8B_kuxfc8Hv4UQo_Lpc2OnevRCyN0IY2sowUiV0nG5y.cEq7hElf3vq.N
 6PQdt7s6CfnFUXqcigYIWc.W.pDTmlcytRc2BLZpJmpsdCuYzJQJ1UiuKkjYyhaPxjZqk4agPLLk
 FxzV6ODxHtY2y96snE1fb2FMiAnFNQIJjj0qEIAbjENER.hz1ZmziKA7ThVjW3qjKCP85U8Skrt_
 2GU67NHAejgJn9QLLLXQRjcEI0GqXB92cA10lTPWQeMWJPLD5HtBWjoVGR7RaIiJJtIak_iPjN_e
 skGfkmMPl2M5yYK7vVDjHvIRQyXsdHSJmEBfbJHrzysULmQC7fLoBcrj7dlUH1KMcwRw.4x4R7FW
 1QjvII.Bm9rMWUyriE6DO6gHc9kWgdKQnPmtcNE4eZzwaZG0Y1V7kR.1F_dk3VQfjzouhAG.3KfL
 RMAJ4VYpFuH9Q1J6I744jHTRW.y95iIBwuCrH0eD1FlDVsu4KYB_U5j4dcsyKPGXv4dGGJiJJyH4
 p8NrdkQVqS9lMZNMxDDxoms8BAqhHjtwiWYsi0wQxTNg06JjcXnLQzLQkZ30HEfyHv16ZbE1BEnI
 CfNADe.qah45J5tXIGDCFF7fTh9Mx5Gt9DWnZGl5JQ8UY1fW_K9M1.haRcFzJZ2FNHRYkBQHiMGp
 hpHXVXvj9a5zybkrdIoM47yocnP7YYgoh6ozLGJOljn5h
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Wed, 10 Jul 2019 23:42:36 +0000
Received: by smtp404.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d9e0da08a84931d992641df66c776383;
          Wed, 10 Jul 2019 23:42:31 +0000 (UTC)
Subject: Re: [RFC PATCH] iomap: generalize IOMAP_INLINE to cover tail-packing
 case
To:     =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>, chao@kernel.org
References: <20190703075502.79782-1-yuchao0@huawei.com>
 <CAHpGcM+s77hKMXo=66nWNF7YKa3qhLY9bZrdb4-Lkspyg2CCDw@mail.gmail.com>
 <39944e50-5888-f900-1954-91be2b12ea5b@huawei.com>
 <CAHpGcMJ_wPJf8KtF3xMP_28pe4Vq4XozFtmd2EuZ+RTqZKQxLA@mail.gmail.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <1506e523-109d-7253-ee4b-961c4264781d@aol.com>
Date:   Thu, 11 Jul 2019 07:42:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAHpGcMJ_wPJf8KtF3xMP_28pe4Vq4XozFtmd2EuZ+RTqZKQxLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


At 2019/7/11 ??????5:50, Andreas Gr??nbacher Wrote:
> At this point, can I ask how important this packing mechanism is to
> you? I can see a point in implementing inline files, which help
> because there tends to be a large number of very small files. But for
> not-so-small files, is saving an extra block really worth the trouble,
> especially given how cheap storage has become?

I would try to answer the above. I think there are several advantages by
using tail-end packing inline:
1) It is more cache-friendly. Considering a file "A" accessed by user
now or recently, we
?????? tend to (1) get more data about "A" (2) leave more data about "A"
according to LRU-like assumption
?????? because it is more likely to be used than the metadata of some other
files "X", especially for files whose
?????? tail-end block is relatively small enough (less than a threshold,
e.g. < 100B just for example);

2) for directories files, tail-end packing will boost up those traversal
performance;

3) I think tail-end packing is a more generic inline, it saves I/Os for
generic cases not just to
?????? save the storage space;

"is saving an extra block really worth the trouble" I dont understand
what exact the trouble is...


Thanks,
Gao Xiang

