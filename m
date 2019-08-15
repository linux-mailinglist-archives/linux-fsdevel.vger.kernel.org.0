Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7548E235
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 02:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfHOA4T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 20:56:19 -0400
Received: from sonic308-19.consmr.mail.ir2.yahoo.com ([77.238.178.147]:45654
        "EHLO sonic308-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727750AbfHOA4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1565830576; bh=x17L5Sqy2ZSt8rwbeOibabFQ+XtkAaG8z2OsU6HiUsA=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=kUck1hwkfUXgt5FTMUxSRNWo/aRpa0EcpBdcBxUQ7WqyH22C0zpWR/RpJx1vk6fiULVNc+BQHCfjnQqg8uy40QUXCt0zFuR/saUSidLutPa09bwGvecppNEzJiR62IdoER+WgIT8YxJq0bn8SvIb65tQH4kq3FMVPe9fb2bD36462Meeh7dhWOP9IUrBsMpqBdI6GfoetKuO8uDbFOf6SW2Ab4rR/Q2xdCL2j7Z7qR6IOu2T/34iV/v9bHsEDIDgMoWURMLxRH96UDr1ZUIAyPijWD1tr1/yUQLyGwVO7/G6UfuXrW9CNJ8Y4XpxCIY9Mh8AK8fAylbSo5m58uIIBA==
X-YMail-OSG: DNqtHREVM1lySEbV5AqOl2qIuSCNlJvzV4p1g6_h4CKDoiE3yxaXT6..lV7cF8r
 YvZrIqPlMvPRmuZZG8FPUAtozXBnYftXri4Wcx4FvPGYOYLnOQXT1wtqpNV6ZuEOLrypyAS_Hy6g
 SclMx6ZNjc3HgSLQaW66MsU0KFVc3TfshrjrHx.UnlkBQlW_GOd8g7H.2XHejIVSST7irHCuN9dd
 mIgPyTVO09Cp6MvfqGUWJpHIcv4WkdDjz9OHoZOSbCgBKEmRIEYHNSC_F0eXMm5E1HjF2L_202Uk
 Cc0ySo.wUPd8n_iOfEvN1qJxS3fpOP0MpY6PSS0PquMxj56AToNu8gTpNaZkNuunxk_i9qZmsa8A
 JaopnwweMpv48RrEpalTmIIk1ojhmt4jHwhDo.X5issGQJ15neLJV56CBHXvhFQGkm.dU1CAaHxe
 b4_9LT8xBeUmoWV_nwF90j8OFx5VWDJOb9Whw4ttBiBdDTvJreZ2ytk7JAD7O4p_zPqlWKrrfAQM
 36Qzw3xjIHtuPxYhH3ou6hxyUFpxjuduOygA1qJa45jmqecLYXHuOPd4csSF7oSJwlA17jonO0e3
 9DX0.Gu3.jnzlJEoTMQgXO5_3iax0jvdFlxdk8cyBPFCE7aRpQqC0nd_w1DdZ6Xgq49eFTzEvYa_
 KPfjD0P393xLnKoOR3YM_OVBEP.sb1cNqLfWmTosd0ySINbhSW0AocEqufLFyUKiZVTzYPSXLV2d
 i.dPWCIB4QP77yM18cYQP6gRdN1R8vy9APm6zik53QiK9hVRL_5AupmWtSOj41o9mDTw7hH7VUhW
 jlYEA9v4VL1y9OY_QmbUwKRrLraI.5.bulJxYtdACur6exqoJwnlNwhNWGQSo29EJBK0NIWJ7PJz
 4dzHExyn1VNb5TQoyppcbTSDP9cb49PiouI5I8iLMJh2d2dTcvTWvQLLg5cBkagDYKSrw0tso55Y
 9Y1n32HIjqo_sUd.apnmuQG8crTBUFBE3dheUNYc6KqLjyBuHjSpHxT2ow.RcuUb01SsuzGWv8Fz
 LYgwOa3Vv7sczdTRbC4VgGG5uT4YGOgwSWbjwyW0tzMMsmOVyVn3a4x6Lui9.4TMfsd_z7vDSKj3
 iyaqOKIlPfkVKbCafvRNlXAW9wMA4IZtceiaEj20sQRHDxY517vyKBrBYorM_Dy.OaMWrFG781Hm
 ROI40IEeomcUptl2EFgQFzMCKunilGRFKWkZ4DFSfkQyRY8VwG8vxTfAF0Rv_M.g8mU4RI1i44D4
 Vd10hD_31qnBk5WHyJm0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Thu, 15 Aug 2019 00:56:16 +0000
Received: by smtp406.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e2aa9151ecba47583be145c94d8fc0ac;
          Thu, 15 Aug 2019 00:56:12 +0000 (UTC)
Date:   Thu, 15 Aug 2019 08:56:05 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     wangyan <wangyan122@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        piaojun <piaojun@huawei.com>
Subject: Re: [QUESTION] A performance problem for buffer write compared with
 9p
Message-ID: <20190815005559.GA14118@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 15, 2019 at 08:30:43AM +0800, wangyan wrote:

[]

> 
> I found that the judgement statement 'if (!TestSetPageDirty(page))' always
> true in function '__set_page_dirty_nobuffers', it will waste much time
> to mark inode dirty, no one page is dirty when write it the second time.
> The buffer write stack:
>     fuse_file_write_iter
>       ->fuse_cache_write_iter
>         ->generic_file_write_iter
>           ->__generic_file_write_iter
>             ->generic_perform_write
>               ->fuse_write_end
>                 ->set_page_dirty
>                   ->__set_page_dirty_nobuffers
> 
> The reason for 'if (!TestSetPageDirty(page))' always true may be the pdflush
> process will clean the page's dirty flags in clear_page_dirty_for_io(),
> and call fuse_writepages_send() to flush all pages to the disk of the host.
> So when the page is written the second time, it always not dirty.
> The pdflush stack for fuse:
>     pdflush
>       ->...
>         ->do_writepages
>           ->fuse_writepages
>             ->write_cache_pages         // will clear all page's dirty flags
>               ->clear_page_dirty_for_io // clear page's dirty flags
>             ->fuse_writepages_send      // write all pages to the host, but
> don't wait the result
> Why not wait for getting the result of writing back pages to the host
> before cleaning all page's dirty flags?
> 

As my understanding, I personally think there's nothing wrong with
the above process from your words above.

Thanks,
Gao Xiang

> As for 9p, pdflush will call clear_page_dirty_for_io() to clean the page's
> dirty flags. Then call p9_client_write() to write the page to the host,
> waiting for the result, and then flush the next page. In this case, buffer
> write of 9p will hit the dirty page many times before it is being write
> back to the host by pdflush process.
> The pdflush stack for 9p:
>     pdflush
>       ->...
>         ->do_writepages
>           ->generic_writepages
>             ->write_cache_pages
>               ->clear_page_dirty_for_io // clear page's dirty flags
>               ->__writepage
>                 ->v9fs_vfs_writepage
>                   ->v9fs_vfs_writepage_locked
>                     ->p9_client_write   // it will get the writing back
> page's result
> 
> 
> According to the test result, is the handling method of 9p for page writing
> back more reasonable than virtiofs?
> 
> Thanks,
> Yan Wang
> 
