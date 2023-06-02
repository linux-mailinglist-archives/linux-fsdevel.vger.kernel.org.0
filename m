Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE0171FCD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjFBI6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 04:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjFBI5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:57:38 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3BC1B6;
        Fri,  2 Jun 2023 01:57:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4QXc5j40qLz9xwj4;
        Fri,  2 Jun 2023 16:45:29 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHll3Krnlk9U37Ag--.3290S2;
        Fri, 02 Jun 2023 09:56:50 +0100 (CET)
Message-ID: <6bb51cd9afb95f2a5bd9bd2a5113f6dcbf4aea07.camel@huaweicloud.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in open_xa_dir
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jeff Mahoney <jeffm@suse.com>, Paul Moore <paul@paul-moore.com>,
        syzbot <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com>
Cc:     hdanton@sina.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        roberto.sassu@huawei.com, syzkaller-bugs@googlegroups.com,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        Jan Kara <jack@suse.cz>
Date:   Fri, 02 Jun 2023 10:56:39 +0200
In-Reply-To: <07c825a21fb4c57f4290158e529d32f4e0e0fbf0.camel@huaweicloud.com>
References: <0000000000007bedb605f119ed9f@google.com>
         <00000000000000964605faf87416@google.com>
         <CAHC9VhTZ=Esk+JxgAjch2J44WuLixe-SZMXW2iGHpLdrdMKQ=g@mail.gmail.com>
         <1020d006-c698-aacc-bcc3-92e5b237ef91@huaweicloud.com>
         <29fcea18-d720-d5df-0e00-eb448e6bbfcf@suse.com>
         <07c825a21fb4c57f4290158e529d32f4e0e0fbf0.camel@huaweicloud.com>
Content-Type: multipart/mixed; boundary="=-JzGDK1esDlvRzhOoEHct"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwDHll3Krnlk9U37Ag--.3290S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFWUCr18Ww43Ww45KFW5trb_yoW5XF4rpr
        WrCF43Krs5tr1jyFs2q3Z8Cw1UtrZ3Cry7Xw4ktry8u3Z2vrnxtr4IyryrWrWDZr4DCFnx
        Aw1akw13Aw1rXwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C267I2x7xF54xIwI1l5I8C
        rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxV
        WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFcxC0VAYjxAxZF0Ex2Iq
        xwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJwCE64xvF2
        IEb7IF0Fy7YxBIdaVFxhVjvjDU0xZFpf9x07UdhL8UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBF1jj4oGjgADsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-JzGDK1esDlvRzhOoEHct
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Fri, 2023-06-02 at 09:20 +0200, Roberto Sassu wrote:
> On Thu, 2023-06-01 at 17:22 -0400, Jeff Mahoney wrote:
> > On 5/31/23 05:49, Roberto Sassu wrote:
> > > On 5/5/2023 11:36 PM, Paul Moore wrote:
> > > > On Fri, May 5, 2023 at 4:51 PM syzbot
> > > > <syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com> wrote:
> > > > > syzbot has bisected this issue to:
> > > > > 
> > > > > commit d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > > > > Author: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > Date:   Fri Mar 31 12:32:18 2023 +0000
> > > > > 
> > > > >      reiserfs: Add security prefix to xattr name in 
> > > > > reiserfs_security_write()
> > > > > 
> > > > > bisection log:  
> > > > > https://syzkaller.appspot.com/x/bisect.txt?x=14403182280000
> > > > > start commit:   3c4aa4434377 Merge tag 'ceph-for-6.4-rc1' of 
> > > > > https://githu..
> > > > > git tree:       upstream
> > > > > final oops:     
> > > > > https://syzkaller.appspot.com/x/report.txt?x=16403182280000
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=12403182280000
> > > > > kernel config:  
> > > > > https://syzkaller.appspot.com/x/.config?x=73a06f6ef2d5b492
> > > > > dashboard link: 
> > > > > https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
> > > > > syz repro:      
> > > > > https://syzkaller.appspot.com/x/repro.syz?x=12442414280000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176a7318280000
> > > > > 
> > > > > Reported-by: syzbot+8fb64a61fdd96b50f3b8@syzkaller.appspotmail.com
> > > > > Fixes: d82dcd9e21b7 ("reiserfs: Add security prefix to xattr name in 
> > > > > reiserfs_security_write()")
> > > > > 
> > > > > For information about bisection process see: 
> > > > > https://goo.gl/tpsmEJ#bisection
> > > > 
> > > > I don't think Roberto's patch identified above is the actual root
> > > > cause of this problem as reiserfs_xattr_set_handle() is called in
> > > > reiserfs_security_write() both before and after the patch.  However,
> > > > due to some bad logic in reiserfs_security_write() which Roberto
> > > > corrected, I'm thinking that it is possible this code is being
> > > > exercised for the first time and syzbot is starting to trigger a
> > > > locking issue in the reiserfs code ... ?
> > > 
> > > + Jan, Jeff (which basically restructured the lock)
> > > 
> > > + Petr, Ingo, Will
> 
> Peter, clearly (sorry!)
> 
> > I involve the lockdep experts, to get a bit of help on this.
> > 
> > Yep, looks like that's been broken since it was added in 2009.  Since 
> > there can't be any users of it, it'd make sense to drop the security 
> > xattr support from reiserfs entirely.
> 
> Thanks, Jeff. Will make a patch to implement your suggestion.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git next

--=-JzGDK1esDlvRzhOoEHct
Content-Disposition: attachment;
	filename*0=0001-reiserfs-Disable-security-xattr-initialization-since.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-reiserfs-Disable-security-xattr-initialization-since.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBhMzFmNWIwOWUzOWU1YTk2NDQ1N2IwYTUyYWE5YzQzN2EwYmY3ZjYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRvLnNhc3N1QGh1YXdlaS5j
b20+CkRhdGU6IEZyaSwgMiBKdW4gMjAyMyAxMDoxMDoyOCArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IHJlaXNlcmZzOiBEaXNhYmxlIHNlY3VyaXR5IHhhdHRyIGluaXRpYWxpemF0aW9uIHNpbmNlIGl0
CiBuZXZlciB3b3JrZWQKCkNvbW1pdCBkODJkY2Q5ZTIxYjcgKCJyZWlzZXJmczogQWRkIHNlY3Vy
aXR5IHByZWZpeCB0byB4YXR0ciBuYW1lIGluCnJlaXNlcmZzX3NlY3VyaXR5X3dyaXRlKCkiKSwg
d2hpbGUgZml4ZWQgdGhlIHNlY3VyaXR5IHhhdHRyIGluaXRpYWxpemF0aW9uLAppdCBhbHNvIHJl
dmVhbGVkIGEgY2lyY3VsYXIgbG9ja2luZyBkZXBlbmRlbmN5IGJldHdlZW4gdGhlIHJlaXNlcmZz
IHdyaXRlCmxvY2sgYW5kIHRoZSBpbm9kZSBsb2NrLgoKU2luY2UgdGhlIGJ1ZyBpbiBzZWN1cml0
eSB4YXR0ciBpbml0aWFsaXphdGlvbiB3YXMgaW50cm9kdWNlZCBzaW5jZSB0aGUKYmVnaW5uaW5n
LCB0aGVyZSBjYW5ub3QgYmUgYW55IHVzZXIgb2YgdGhpcyBmZWF0dXJlLiBJbnN0ZWFkIG9mIHRy
eWluZyB0bwpmaXggdGhlIGxvY2tpbmcgZGVwZW5kZW5jeSwgd2hpY2ggd2FzIGFscmVhZHkgY2hh
bGxlbmdpbmcgdG8gY29udmVydCBmcm9tCkJMSywganVzdCBkaXNhYmxlIHRoZSBmZWF0dXJlLgoK
SG93ZXZlciwgc3RpbGwga2VlcCB0aGUgc2VjdXJpdHkgeGF0dHIgaGFuZGxlciwgc2luY2UgaXQg
d2FzIGludHJvZHVjZWQKZWFybGllciwgYW5kIHVzZXJzIG1pZ2h0IGhhdmUgbWFudWFsbHkgYWRk
ZWQgeGF0dHJzLgoKUmVwb3J0ZWQtYnk6IHN5emJvdCs4ZmI2NGE2MWZkZDk2YjUwZjNiOEBzeXpr
YWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5j
b20vYnVnP2V4dGlkPThmYjY0YTYxZmRkOTZiNTBmM2I4ClN1Z2dlc3RlZC1ieTogSmVmZiBNYWhv
bmV5IDxqZWZmbUBzdXNlLmNvbT4KU2lnbmVkLW9mZi1ieTogUm9iZXJ0byBTYXNzdSA8cm9iZXJ0
by5zYXNzdUBodWF3ZWkuY29tPgotLS0KIGZzL3JlaXNlcmZzL3N1cGVyLmMgICAgICAgICAgfCAy
ICsrCiBmcy9yZWlzZXJmcy94YXR0cl9zZWN1cml0eS5jIHwgMyArKysKIDIgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvcmVpc2VyZnMvc3VwZXIuYyBiL2Zz
L3JlaXNlcmZzL3N1cGVyLmMKaW5kZXggOTI5YWNjZTZlNzMuLjI2MjA0MWI4N2NkIDEwMDY0NAot
LS0gYS9mcy9yZWlzZXJmcy9zdXBlci5jCisrKyBiL2ZzL3JlaXNlcmZzL3N1cGVyLmMKQEAgLTE2
NTQsNiArMTY1NCw4IEBAIHN0YXRpYyBpbnQgcmVhZF9zdXBlcl9ibG9jayhzdHJ1Y3Qgc3VwZXJf
YmxvY2sgKnMsIGludCBvZmZzZXQpCiAKIAlyZWlzZXJmc193YXJuaW5nKE5VTEwsICIiLCAicmVp
c2VyZnMgZmlsZXN5c3RlbSBpcyBkZXByZWNhdGVkIGFuZCAiCiAJCSJzY2hlZHVsZWQgdG8gYmUg
cmVtb3ZlZCBmcm9tIHRoZSBrZXJuZWwgaW4gMjAyNSIpOworCXJlaXNlcmZzX3dhcm5pbmcoTlVM
TCwgIiIsICJpbml0aWFsaXppbmcgc2VjdXJpdHkgeGF0dHJzIG5ldmVyIHdvcmtlZCwgZGlzYWJs
ZSBpdCIpOworCiAJU0JfQlVGRkVSX1dJVEhfU0IocykgPSBiaDsKIAlTQl9ESVNLX1NVUEVSX0JM
T0NLKHMpID0gcnM7CiAKZGlmZiAtLWdpdCBhL2ZzL3JlaXNlcmZzL3hhdHRyX3NlY3VyaXR5LmMg
Yi9mcy9yZWlzZXJmcy94YXR0cl9zZWN1cml0eS5jCmluZGV4IDA3OGRkOGNjMzEyLi40MDM3YTk5
OGRiZiAxMDA2NDQKLS0tIGEvZnMvcmVpc2VyZnMveGF0dHJfc2VjdXJpdHkuYworKysgYi9mcy9y
ZWlzZXJmcy94YXR0cl9zZWN1cml0eS5jCkBAIC02OSw2ICs2OSw5IEBAIGludCByZWlzZXJmc19z
ZWN1cml0eV9pbml0KHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCXNl
Yy0+dmFsdWUgPSBOVUxMOwogCXNlYy0+bGVuZ3RoID0gMDsKIAorCS8qIFNlZSB3YXJuaW5nIGlu
IHJlYWRfc3VwZXJfYmxvY2soKS4gKi8KKwlyZXR1cm4gMDsKKwogCS8qIERvbid0IGFkZCBzZWxp
bnV4IGF0dHJpYnV0ZXMgb24geGF0dHJzIC0gdGhleSdsbCBuZXZlciBnZXQgdXNlZCAqLwogCWlm
IChJU19QUklWQVRFKGRpcikpCiAJCXJldHVybiAwOwotLSAKMi4yNS4xCgo=


--=-JzGDK1esDlvRzhOoEHct--

