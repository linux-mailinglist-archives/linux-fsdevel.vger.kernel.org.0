Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438A268D14F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 09:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBGIMa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 03:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBGIM3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:12:29 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D664367F1;
        Tue,  7 Feb 2023 00:12:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vb6JCLB_1675757538;
Received: from 30.221.130.169(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vb6JCLB_1675757538)
          by smtp.aliyun-inc.com;
          Tue, 07 Feb 2023 16:12:20 +0800
Content-Type: multipart/mixed; boundary="------------TpH0jGwNqzjhmhRArln0apbo"
Message-ID: <a526afef-a5ce-ceec-d5b7-1da9fab1a18f@linux.alibaba.com>
Date:   Tue, 7 Feb 2023 16:12:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Larsson <alexl@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
References: <cover.1674227308.git.alexl@redhat.com>
 <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
 <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
 <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
 <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com>
 <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
 <071074ad149b189661681aada453995741f75039.camel@redhat.com>
 <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com>
 <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
 <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
 <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com>
 <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
 <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
 <CAOQ4uxjNmM81mgKOBJeScnmeR9+jG_aWvDWxAx7w_dGh0XHg3Q@mail.gmail.com>
 <5fbca304-369d-aeb8-bc60-fdb333ca7a44@linux.alibaba.com>
 <CAOQ4uximQZ_DL1atbrCg0bQ8GN8JfrEartxDSP+GB_hFvYQOhg@mail.gmail.com>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAOQ4uximQZ_DL1atbrCg0bQ8GN8JfrEartxDSP+GB_hFvYQOhg@mail.gmail.com>
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------TpH0jGwNqzjhmhRArln0apbo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi amir and all,


On 2/6/23 3:06 AM, Amir Goldstein wrote:
>>>>> Apart from that, I still fail to get some thoughts (apart from
>>>>> unprivileged
>>>>> mounts) how EROFS + overlayfs combination fails on automative real
>>>>> workloads
>>>>> aside from "ls -lR" (readdir + stat).
>>>>>
>>>>> And eventually we still need overlayfs for most use cases to do
>>>>> writable
>>>>> stuffs, anyway, it needs some words to describe why such < 1s
>>>>> difference is
>>>>> very very important to the real workload as you already mentioned
>>>>> before.
>>>>>
>>>>> And with overlayfs lazy lookup, I think it can be close to ~100ms or
>>>>> better.
>>>>>
>>>>
>>>> If we had an overlay.fs-verity xattr, then I think there are no
>>>> individual features lacking for it to work for the automotive usecase
>>>> I'm working on. Nor for the OCI container usecase. However, the
>>>> possibility of doing something doesn't mean it is the better technical
>>>> solution.
>>>>
>>>> The container usecase is very important in real world Linux use today,
>>>> and as such it makes sense to have a technically excellent solution for
>>>> it, not just a workable solution. Obviously we all have different
>>>> viewpoints of what that is, but these are the reasons why I think a
>>>> composefs solution is better:
>>>>
>>>> * It is faster than all other approaches for the one thing it actually
>>>> needs to do (lookup and readdir performance). Other kinds of
>>>> performance (file i/o speed, etc) is up to the backing filesystem
>>>> anyway.
>>>>
>>>> Even if there are possible approaches to make overlayfs perform better
>>>> here (the "lazy lookup" idea) it will not reach the performance of
>>>> composefs, while further complicating the overlayfs codebase. (btw, did
>>>> someone ask Miklos what he thinks of that idea?)
>>>>
>>>
>>> Well, Miklos was CCed (now in TO:)
>>> I did ask him specifically about relaxing -ouserxarr,metacopy,redirect:
>>> https://lore.kernel.org/linux-unionfs/20230126082228.rweg75ztaexykejv@wittgenstein/T/#mc375df4c74c0d41aa1a2251c97509c6522487f96
>>> but no response on that yet.
>>>
>>> TBH, in the end, Miklos really is the one who is going to have the most
>>> weight on the outcome.
>>>
>>> If Miklos is interested in adding this functionality to overlayfs, you are going
>>> to have a VERY hard sell, trying to merge composefs as an independent
>>> expert filesystem. The community simply does not approve of this sort of
>>> fragmentation unless there is a very good reason to do that.
>>>
>>>> For the automotive usecase we have strict cold-boot time requirements
>>>> that make cold-cache performance very important to us. Of course, there
>>>> is no simple time requirements for the specific case of listing files
>>>> in an image, but any improvement in cold-cache performance for both the
>>>> ostree rootfs and the containers started during boot will be worth its
>>>> weight in gold trying to reach these hard KPIs.
>>>>
>>>> * It uses less memory, as we don't need the extra inodes that comes
>>>> with the overlayfs mount. (See profiling data in giuseppes mail[1]).
>>>
>>> Understood, but we will need profiling data with the optimized ovl
>>> (or with the single blob hack) to compare the relevant alternatives.
>>
>> My little request again, could you help benchmark on your real workload
>> rather than "ls -lR" stuff?  If your hard KPI is really what as you
>> said, why not just benchmark the real workload now and write a detailed
>> analysis to everyone to explain it's a _must_ that we should upstream
>> a new stacked fs for this?
>>
> 
> I agree that benchmarking the actual KPI (boot time) will have
> a much stronger impact and help to build a much stronger case
> for composefs if you can prove that the boot time difference really matters.
> 
> In order to test boot time on fair grounds, I prepared for you a POC
> branch with overlayfs lazy lookup:
> https://github.com/amir73il/linux/commits/ovl-lazy-lowerdata
> 
> It is very lightly tested, but should be sufficient for the benchmark.
> Note that:
> 1. You need to opt-in with redirect_dir=lazyfollow,metacopy=on
> 2. The lazyfollow POC only works with read-only overlay that
>     has two lower dirs (1 metadata layer and one data blobs layer)
> 3. The data layer must be a local blockdev fs (i.e. not a network fs)
> 4. Only absolute path redirects are lazy (e.g. "/objects/cc/3da...")
> 
> These limitations could be easily lifted with a bit more work.
> If any of those limitations stand in your way for running the benchmark
> let me know and I'll see what I can do.
> 

Thanks for the lazyfollow POC, I updated the perf test with overlayfs
lazyfollow enabled.

				            | uncached(ms)| cached(ms)
----------------------------------------------------+-----+----
composefs	  		    		    | 404 | 181
composefs (readahead of manifest disabled) 	    | 523 | 178

erofs (loop BUFFER)	  		    	    | 300 | 188
erofs (loop DIRECT)	  		    	    | 486 | 188
erofs (loop DIRECT + ra manifest)        	    | 292 | 190

erofs (loop BUFFER) 	       +overlayfs(lazyfollowup) | 502 | 286
erofs (loop DIRECT) 	       +overlayfs(lazyfollowup) | 686 | 285
erofs (loop DIRECT+ra manifest)+overlayfs(lazyfollowup) | 484 | 300


I find that composefs behaves better than purely erofs (loop DIRECT),
e.g. 404ms vs 486ms in uncached situation, somewhat because composefs
reads part of metadata by buffered kernel_read() and thus the builtin
readahead is performed on the manifest file.  With the readahead for the
manifest disabled, the performance gets much worse.

Erofs can also use similar optimization of readahead the manifest file
when accessing the metadata if really needed.  An example POC
implementation is inlined in the bottom of this mail.  Considering the
workload of "ls -lR" will read basically the full content of the
manifest file, plusing the manifest file size is just ~10MB, the POC
implementation just performs async readahead upon the manifest with a
fixed step of 128KB.  With this opt-in, erofs performs somewhat better
in uncached situation.  I have to admit that this much depends on the
range and the step size of the readahead, but at least it indicates that
erofs can get comparable performance with similar optimization.


Besides, as mentioned in [1], in composefs the on-disk inode under one
directory is arranged closer than erofs, which means the submitted IO
when doing "ls -l" in erofs is more random than that in composefs,
somewhat affecting the performance. It can be possibly fixed by
improving mkfs.erofs if the gap (~80ms) really matters.

The inode id arrangement under the root directory of tested rootfs is
shown as an attachment, and the tested erofs image of erofs+overlayfs is
constructed from the script (mkhack.sh) attached in [2] offered by
Alexander.



To summarize:

For composefs and erofs, they are quite similar and the performance is
also comparable (with the same optimization).

But when comparing composefs and erofs+overlayfs(lazyfollowup), at least
in the workload of "ls -lR", the combination of erofs and overlayfs
costs ~100ms more in both cached and uncached situation.  If such ~100ms
diff really matters, erofs could resolve "redirect" xattr itself, in
which case overlayfs is not involved and then the performance shall be
comparable with composefs, but i'm not sure if it's worthwhile
considering the results are already close. Besides the rootfs is
read-only in this case, and if we need writable layer anyway, overlayfs
still needs to be introduced.



[1]
https://lore.kernel.org/lkml/1d65be2f-6d3a-13c6-4982-66bbb0f9b530@linux.alibaba.com/
[2]
https://lore.kernel.org/linux-fsdevel/5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com/


diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d3b8736fa124..e74e24e00b49 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -21,6 +21,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
        struct erofs_inode_compact *dic;
        struct erofs_inode_extended *die, *copied = NULL;
        unsigned int ifmt;
+       struct folio *folio;
+       struct inode *binode = sb->s_bdev->bd_inode;
+       struct address_space *mapping = binode->i_mapping;
+       pgoff_t index = inode_loc >> PAGE_SHIFT;
        int err;

        blkaddr = erofs_blknr(inode_loc);
@@ -29,6 +33,16 @@ static void *erofs_read_inode(struct erofs_buf *buf,
        erofs_dbg("%s, reading inode nid %llu at %u of blkaddr %u",
                  __func__, vi->nid, *ofs, blkaddr);

+       folio = filemap_get_folio(mapping, index);
+       if (!folio || !folio_test_uptodate(folio)) {
+               loff_t isize = i_size_read(binode);
+               pgoff_t end_index = (isize - 1) >> PAGE_SHIFT;
+               unsigned long nr_to_read = min_t(unsigned long,
end_index - index, 32);
+               DEFINE_READAHEAD(ractl, NULL, NULL, mapping, index);
+
+               page_cache_ra_unbounded(&ractl, nr_to_read, 0);
+       }
+
        kaddr = erofs_read_metabuf(buf, sb, blkaddr, EROFS_KMAP);
        if (IS_ERR(kaddr)) {
                erofs_err(sb, "failed to get inode (nid: %llu) page, err
%ld",

-- 
Thanks,
Jingbo
--------------TpH0jGwNqzjhmhRArln0apbo
Content-Type: text/plain; charset=UTF-8; name="inode_arrange.txt"
Content-Disposition: attachment; filename="inode_arrange.txt"
Content-Transfer-Encoding: base64

Y29tcG9zZWZzOgo9PT09PT09PT0KCiMgbHMgLWlsIC9tbnQvY3BzCi9tbnQvY3BzOgogMSBk
ci14ci14ci14ICAyIHJvb3Qgcm9vdCAgICA2IDjmnIggIDEwIDIwMjEgYWZzCiAyIGxyd3hy
d3hyd3ggIDEgcm9vdCByb290ICAgIDcgOOaciCAgMTAgMjAyMSBiaW4gLT4gdXNyL2Jpbgog
MyBkci14ci14ci14ICA1IHJvb3Qgcm9vdCAgMjcwIDHmnIggIDE3IDE4OjE1IGJvb3QKIDQg
ZHJ3eHIteHIteCAgMiByb290IHJvb3QgICAgNiAx5pyIICAxNyAxODoxNCBkZXYKIDUgZHJ3
eHIteHIteCA4NyByb290IHJvb3QgNDA5NiAx5pyIICAxNyAxODoxNSBldGMKIDYgZHJ3eHIt
eHIteCAgMyByb290IHJvb3QgICAxOSAx5pyIICAxNyAxODoxNSBob21lCiA3IGxyd3hyd3hy
d3ggIDEgcm9vdCByb290ICAgIDcgOOaciCAgMTAgMjAyMSBsaWIgLT4gdXNyL2xpYgogOCBs
cnd4cnd4cnd4ICAxIHJvb3Qgcm9vdCAgICA5IDjmnIggIDEwIDIwMjEgbGliNjQgLT4gdXNy
L2xpYjY0CiA5IGRyd3hyLXhyLXggIDIgcm9vdCByb290ICAgIDYgOOaciCAgMTAgMjAyMSBt
ZWRpYQoxMCBkcnd4ci14ci14ICAyIHJvb3Qgcm9vdCAgICA2IDjmnIggIDEwIDIwMjEgbW50
CjExIGRyd3hyLXhyLXggIDMgcm9vdCByb290ICAgMTYgMeaciCAgMTcgMTg6MTQgb3B0CjEy
IGRyd3hyLXhyLXggIDIgcm9vdCByb290ICAgIDYgMeaciCAgMTcgMTg6MTQgcHJvYwoxMyBk
ci14ci14LS0tICAzIHJvb3Qgcm9vdCAgMTAzIDHmnIggIDE3IDE4OjE1IHJvb3QKMTQgZHJ3
eHIteHIteCAxNCByb290IHJvb3QgIDE4NyAx5pyIICAxNyAxODoxNSBydW4KMTUgbHJ3eHJ3
eHJ3eCAgMSByb290IHJvb3QgICAgOCA45pyIICAxMCAyMDIxIHNiaW4gLT4gdXNyL3NiaW4K
MTYgZHJ3eHIteHIteCAgMiByb290IHJvb3QgICAgNiA45pyIICAxMCAyMDIxIHNydgoxNyBk
cnd4ci14ci14ICAyIHJvb3Qgcm9vdCAgICA2IDHmnIggIDE3IDE4OjE0IHN5cwoxOCBkcnd4
cnd4cnd0ICAzIHJvb3Qgcm9vdCAgIDI5IDHmnIggIDE3IDE4OjE1IHRtcAoxOSBkcnd4ci14
ci14IDEyIHJvb3Qgcm9vdCAgMTQ0IDHmnIggIDE3IDE4OjE0IHVzcgoyMCBkcnd4ci14ci14
IDE4IHJvb3Qgcm9vdCAgMjM1IDHmnIggIDE3IDE4OjE0IHZhcgoKCmVyb2ZzOgo9PT09Cgoj
IGxzIC1pbCAvbW50L2Vyb2ZzLXJhdy9ib290c3RyYXAKL21udC9lcm9mcy1yYXcvYm9vdHN0
cmFwOgogIDExNDkgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwMAogIDEwMTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwMQogIDEwMTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwMgogIDEwMjAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwMwogIDEwMjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwNAogIDExNTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwNQogIDExNTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwNgogIDExNTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwNwogIDExNTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwOAogIDExNjAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwOQogIDExNjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwYQogIDExNjQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwYgogIDExNjYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwYwogIDExNjggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwZAogIDExNzAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwZQogIDExNzIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAwZgogIDExNzQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxMAogIDExNzYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxMQogIDExNzggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxMgogIDExODAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxMwogIDExODIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxNAogIDExODQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxNQogIDExODYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxNgogIDExODggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxNwogIDExOTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxOAogIDExOTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxOQogIDExOTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxYQogIDExOTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxYgogIDExOTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxYwogIDEyMDAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxZAogIDEyMDIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxZQogIDEyMDQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAxZgogIDEyMDYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyMAogIDEyMDggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyMQogIDEyMTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyMgogIDEyMTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyMwogIDEyMTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyNAogIDEyMTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyNQogIDEyMTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyNgogIDEyMjAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyNwogIDEyMjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyOAogIDEyMjQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyOQogIDEyMjYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyYQogIDEyMjggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyYgogIDEyMzAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyYwogIDEyMzIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyZAogIDEyMzQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyZQogIDEyMzYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAyZgogIDEyMzggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzMAogIDEyNDAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzMQogIDEyNDIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzMgogIDEyNDQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzMwogIDEyNDYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzNAogIDEyNDggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzNQogIDEyNTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzNgogIDEyNTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzNwogIDEyNTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzOAogIDEyNTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzOQogIDEyNTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzYQogIDEyNjAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzYgogIDEyNjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzYwogIDEyNjQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzZAogIDEyNjYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzZQogIDEyNjggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCAzZgogIDEyNzAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0MAogIDEyNzIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0MQogIDEyNzQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0MgogIDEyNzYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0MwogIDEyODAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0NAogIDEyNzggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0NQogIDEyODIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0NgogIDEyODQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0NwogIDEyODYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0OAogIDEyODggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0OQogIDEyOTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0YQogIDEyOTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0YgogIDEyOTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0YwogIDEyOTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0ZAogIDEyOTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0ZQogIDEzMDAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA0ZgogIDEzMDIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1MAogIDEzMDQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1MQogIDEzMDYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1MgogIDEzMDggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1MwogIDEzMTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1NAogIDEzMTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1NQogIDEzMTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1NgogIDEzMTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1NwogIDEzMTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1OAogIDEzMjAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1OQogIDEzMjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1YQogIDEzMjQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1YgogIDEzMjYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1YwogIDEzMjggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1ZAogIDEzMzAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1ZQogIDEzMzIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA1ZgogIDEzMzQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2MAogIDEzMzYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2MQogIDEzMzggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2MgogIDEzNDAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2MwogIDEzNDIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2NAogIDEzNDQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2NQogIDEzNDYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2NgogIDEzNDggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2NwogIDEzNTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2OAogIDEzNTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2OQogIDEzNTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2YQogIDEzNTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2YgogIDEzNTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2YwogIDEzNjAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2ZAogIDEzNjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2ZQogIDEzNjQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA2ZgogIDEzNjYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3MAogIDEzNjggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3MQogIDEzNzAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3MgogIDEzNzIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3MwogIDEzNzQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3NAogIDEzNzYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3NQogIDEzNzggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3NgogIDEzODAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3NwogIDEzODIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3OAogIDEzODQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3OQogIDEzODYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3YQogIDEzODggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3YgogIDEzOTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3YwogIDEzOTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3ZAogIDEzOTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3ZQogIDEzOTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA3ZgogIDEzOTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4MAogIDE0MDAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4MQogIDE0MDIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4MgogIDE0MDQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4MwogIDE0MDggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4NAogIDE0MDYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4NQogIDE0MTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4NgogIDE0MTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4NwogIDE0MTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4OAogIDE0MTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4OQogIDE0MTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4YQogIDE0MjAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4YgogIDE0MjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4YwogIDE0MjQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4ZAogIDE0MjYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4ZQogIDE0MjggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA4ZgogIDE0MzAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5MAogIDE0MzIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5MQogIDE0MzQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5MgogIDE0MzYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5MwogIDE0MzggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5NAogIDE0NDAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5NQogIDE0NDIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5NgogIDE0NDQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5NwogIDE0NDYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5OAogIDE0NDggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5OQogIDE0NTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5YQogIDE0NTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5YgogIDE0NTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5YwogIDE0NTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5ZAogIDE0NTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5ZQogIDE0NjAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCA5ZgogIDE0NjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhMAogIDE0NjQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhMQogIDE0NjYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhMgogIDE0NjggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhMwogIDE0NzAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhNAogIDE0NzIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhNQogIDE0NzQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhNgogIDE0NzYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhNwogIDE0NzggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhOAogIDE0ODAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhOQogIDE0ODIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhYQogIDE0ODQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhYgogIDE0ODYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhYwogIDE0ODggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhZAogIDE0OTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhZQogIDE0OTIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBhZgogIDE0OTQgZHIteHIteHIteCAgMiByb290IHJvb3QgICAyNyA45pyIICAxMCAyMDIx
IGFmcwogIDE0OTcgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiMAogIDE0OTkgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiMQogIDE1MDEgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiMgogIDE1MDMgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiMwogIDE1MDUgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiNAogIDE1MDcgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiNQogIDE1MDkgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiNgogIDE1MTEgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiNwogIDE1MTMgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiOAogIDE1MTUgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiOQogIDE1MTcgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiYQogIDE1MTkgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiYgogIDE1MjEgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiYwogIDE1MjMgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiZAogIDE1MjUgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiZQogIDE1MjcgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwgMCAy5pyIICAgMiAxMTow
MCBiZgogIDE1MjkgbHJ3eHJ3eHJ3eCAgMSByb290IHJvb3QgICAgNyA45pyIICAxMCAyMDIx
IGJpbiAtPiB1c3IvYmluCiAgMTUzNiBkci14ci14ci14ICA1IHJvb3Qgcm9vdCAgMzIzIDHm
nIggIDE3IDE4OjE1IGJvb3QKICAxNjYxIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzAKICAxNjc0IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzEKICAxNjc2IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzIKICAxNjc4IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzMKICAxNjgwIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzQKICAxNjgyIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzUKICAxNjg0IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzYKICAxNjg2IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzcKICAxNjg4IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzgKICAxNjkwIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgYzkKICAxNjkyIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgY2EKICAxNjk0IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgY2IKICAxNjk2IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgY2MKICAxNjk4IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgY2QKICAxNzAwIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgY2UKICAxNzAyIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgY2YKICAxNzA0IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDAKICAxNzA2IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDEKICAxNzA4IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDIKICAxNzEwIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDMKICAxNzEyIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDQKICAxNzE0IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDUKICAxNzE2IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDYKICAxNzE4IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDcKICAxNzIwIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDgKICAxNzIyIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZDkKICAxNzI0IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZGEKICAxNzI2IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZGIKICAxNzI4IGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZGMKICAxNzMwIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZGQKICAxNzMyIGNydy1yLS1yLS0gIDEgcm9vdCByb290IDAsIDAg
MuaciCAgIDIgMTE6MDAgZGUKICAxNzM0IGRyd3hyLXhyLXggIDIgcm9vdCByb290ICAgMjcg
MeaciCAgMTcgMTg6MTQgZGV2CiAgMTczNyBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGRmCiAgMTczOSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGUwCiAgMTc0MSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGUxCiAgMTc0MyBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGUyCiAgMTc0NSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGUzCiAgMTc0NyBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGU0CiAgMTc0OSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGU1CiAgMTc1MSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGU2CiAgMTc1MyBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGU3CiAgMTc1NSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGU4CiAgMTc1NyBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGU5CiAgMTc1OSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGVhCiAgMTc2MSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGViCiAgMTc2MyBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGVjCiAgMTc2NSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGVkCiAgMTc2NyBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGVlCiAgMTc2OSBjcnctci0tci0tICAxIHJvb3Qgcm9vdCAwLCAw
IDLmnIggICAyIDExOjAwIGVmCiAgMTc5MiBkcnd4ci14ci14IDg3IHJvb3Qgcm9vdCAzMjU1
IDHmnIggIDE3IDE4OjE1IGV0YwogIDQ4NjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmMAogIDQ3MzQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmMQogIDI5NDIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmMgogIDQ5OTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmMwogIDQzNTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmNAogIDM3MTAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmNQogIDIxNzQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmNgogIDYxMTQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmNwogIDYxMTYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmOAogIDYxMTggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmOQogIDYxMjAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmYQogIDYxMjIgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmYgogIDYxMjQgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmYwogIDYxMjYgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmZAogIDYxMjggY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmZQogIDYxMzAgY3J3LXItLXItLSAgMSByb290IHJvb3QgMCwg
MCAy5pyIICAgMiAxMTowMCBmZgogIDYxMzIgZHJ3eHIteHIteCAgMyByb290IHJvb3QgICA0
NCAx5pyIICAxNyAxODoxNSBob21lCiAgNjE2MiBscnd4cnd4cnd4ICAxIHJvb3Qgcm9vdCAg
ICA3IDjmnIggIDEwIDIwMjEgbGliIC0+IHVzci9saWIKICA2MTY1IGxyd3hyd3hyd3ggIDEg
cm9vdCByb290ICAgIDkgOOaciCAgMTAgMjAyMSBsaWI2NCAtPiB1c3IvbGliNjQKICA2MTY4
IGRyd3hyLXhyLXggIDIgcm9vdCByb290ICAgMjcgOOaciCAgMTAgMjAyMSBtZWRpYQogIDYx
NzEgZHJ3eHIteHIteCAgMiByb290IHJvb3QgICAyNyA45pyIICAxMCAyMDIxIG1udAogIDYx
NzQgZHJ3eHIteHIteCAgMyByb290IHJvb3QgICA0MSAx5pyIICAxNyAxODoxNCBvcHQKIDE1
MjIxIGRyd3hyLXhyLXggIDIgcm9vdCByb290ICAgMjcgMeaciCAgMTcgMTg6MTQgcHJvYwog
MTUyMjQgZHIteHIteC0tLSAgMyByb290IHJvb3QgIDE0OCAx5pyIICAxNyAxODoxNSByb290
CiAxNTI1OSBkcnd4ci14ci14IDE0IHJvb3Qgcm9vdCAgMjYwIDHmnIggIDE3IDE4OjE1IHJ1
bgogMTUzMzkgbHJ3eHJ3eHJ3eCAgMSByb290IHJvb3QgICAgOCA45pyIICAxMCAyMDIxIHNi
aW4gLT4gdXNyL3NiaW4KIDE1MzQyIGRyd3hyLXhyLXggIDIgcm9vdCByb290ICAgMjcgOOac
iCAgMTAgMjAyMSBzcnYKIDE1MzQ1IGRyd3hyLXhyLXggIDIgcm9vdCByb290ICAgMjcgMeac
iCAgMTcgMTg6MTQgc3lzCiAxNTM0OCBkcnd4cnd4cnd0ICAzIHJvb3Qgcm9vdCAgIDU0IDHm
nIggIDE3IDE4OjE1IHRtcAogMTUzNjYgZHJ3eHIteHIteCAxMiByb290IHJvb3QgIDIwOSAx
5pyIICAxNyAxODoxNCB1c3IKMjgwNzQwIGRyd3hyLXhyLXggMTggcm9vdCByb290ICAzMzIg
MeaciCAgMTcgMTg6MTQgdmFy

--------------TpH0jGwNqzjhmhRArln0apbo--
