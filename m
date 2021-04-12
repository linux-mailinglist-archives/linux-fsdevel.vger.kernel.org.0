Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4512235C97E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbhDLPNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239412AbhDLPNm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:13:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30B2C061574;
        Mon, 12 Apr 2021 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=K3QQt32e+Ihaan+cSsO36hLhVbEl1gWUBbtc6CSo5/4=; b=SgG2eZxQDMaYmy1kiGQruMdsRS
        Uh8yCsBn5X9yhqiVAzJskKImfSsMHYxd1nOtKuAwtTRPVWK9SeocL4XGiSPdiaE9JG9kG3ejlSuMs
        3akFFQX8EPNxUiplBfe6v2KWq70xhlxlVJBOGqBFCa5Ylso5Oj856HzhK3UyaRja4x+Qh2Fwxj3uR
        Rc0I0KkMA+FY9at0wroT6gARQYbK4iy5k5o7Wr6hxZg5tEU4xxRd8eaS+xB0aCI74oSEp6XhAK3tX
        he2Nkr4Qc1gDzXeLFVdPRvI2pWmNf7o6EgGgom2rClzpr5KrHmstDMY/92Fjok5ZP9/7+ODhMV4G0
        Jvt+yBAg==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVyFd-0072YN-3o; Mon, 12 Apr 2021 15:13:21 +0000
Subject: Re: mmotm 2021-04-11-20-47 uploaded (fs/io_uring.c)
To:     Jens Axboe <axboe@kernel.dk>, akpm@linux-foundation.org,
        broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
References: <20210412034813.EK9k9%akpm@linux-foundation.org>
 <34ed89e1-683e-7c12-ceb0-f5b71148a8a7@infradead.org>
 <9533afdd-208e-c25d-2e11-cc7f2c9d147b@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <99c73206-8273-665a-0c66-2582873ffa48@infradead.org>
Date:   Mon, 12 Apr 2021 08:13:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <9533afdd-208e-c25d-2e11-cc7f2c9d147b@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/12/21 5:39 AM, Jens Axboe wrote:
> On 4/12/21 1:21 AM, Randy Dunlap wrote:
>> On 4/11/21 8:48 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2021-04-11-20-47 has been uploaded to
>>>
>>>    https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> https://ozlabs.org/~akpm/mmotm/series
>>>
>>> The file broken-out.tar.gz contains two datestamp files: .DATE and
>>> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
>>> followed by the base kernel version against which this patch series is to
>>> be applied.
>>>
>>> This tree is partially included in linux-next.  To see which patches are
>>> included in linux-next, consult the `series' file.  Only the patches
>>> within the #NEXT_PATCHES_START/#NEXT_PATCHES_END markers are included in
>>> linux-next.
>>
>> on i386:
>> # CONFIG_BLOCK is not set
>>
>> ../fs/io_uring.c: In function ‘kiocb_done’:
>> ../fs/io_uring.c:2766:7: error: implicit declaration of function ‘io_resubmit_prep’; did you mean ‘io_put_req’? [-Werror=implicit-function-declaration]
>>    if (io_resubmit_prep(req)) {
> 
> I'll apply the below to take care of that.
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 3a837d2b8331..aa29918944f6 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2464,6 +2464,10 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
>  	return true;
>  }
>  #else
> +static bool io_resubmit_prep(struct io_kiocb *req)
> +{
> +	return false;
> +}
>  static bool io_rw_should_reissue(struct io_kiocb *req)
>  {
>  	return false;
> @@ -2504,14 +2508,8 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res, long res2)
>  	if (kiocb->ki_flags & IOCB_WRITE)
>  		kiocb_end_write(req);
>  	if (unlikely(res != req->result)) {
> -		bool fail = true;
> -
> -#ifdef CONFIG_BLOCK
> -		if (res == -EAGAIN && io_rw_should_reissue(req) &&
> -		    io_resubmit_prep(req))
> -			fail = false;
> -#endif
> -		if (fail) {
> +		if (!(res == -EAGAIN && io_rw_should_reissue(req) &&
> +		    io_resubmit_prep(req))) {
>  			req_set_fail_links(req);
>  			req->flags |= REQ_F_DONT_REISSUE;
>  		}
> 


-- 
~Randy

