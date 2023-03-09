Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836DB6B17A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 01:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCIAKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 19:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCIAJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:09:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10FBC6430;
        Wed,  8 Mar 2023 16:09:04 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MYvY2-1q4uXN2LsO-00Uvrc; Thu, 09
 Mar 2023 01:08:38 +0100
Content-Type: multipart/mixed; boundary="------------vYYRrMr75mZWgPjdmqDRCG6e"
Message-ID: <9c59ce30-f217-568e-a3a0-f5a8fd1ac107@gmx.com>
Date:   Thu, 9 Mar 2023 08:08:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-4-hch@lst.de>
 <88b2fae1-8d95-2172-7bc4-c5dfc4ff7410@gmx.com>
 <20230307144106.GA19477@lst.de>
 <96f5c29c-1b25-66af-1ba1-731ae39d912d@gmx.com>
 <5aff53ea-0666-d4d6-3bf1-07b3674a405a@gmx.com>
 <20230308142817.GA14929@lst.de>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct
 btrfs_bio
In-Reply-To: <20230308142817.GA14929@lst.de>
X-Provags-ID: V03:K1:eBf4ygD0mYRNIlxdOGIjCi9VKbnoyqOCPvD7IVUxZZMF5rHuQ8K
 cijUxIAXRdyVLXMW3HVwdBJNxyYY8win9Nq2pklMfS6RLF+Zs3lOQKfnRGYMAihH3P5PuFr
 /r6zwxP6OHlIg28KV+IAveEzPqDjtkUdMj04Fsg0IpzscSfiMRlyGf+EzKNMfkdYSsHdXi8
 Kox6gRTWGpBAD+IshsjlQ==
UI-OutboundReport: notjunk:1;M01:P0:UNkdXbhrdFk=;g0A36h0EMxsyhpZeovcA3KqRWpt
 ahNW9eW1tV2d5N2xUOQlRrND9CA5c7xb3De44+EFPeqdobC1y7YB6+97qo1sIpTG/Rz14pTVl
 bVdYyBCH111frUUrxoqgIiJpWVr4ef8nFCSiO5jbYdliHc1EEIu9D5z+/I+qWeBkCK73AkUO8
 SyH12xbD/kTAQZWiBFDHNqX1GdfyYw4h6SMjiNOBq0p7JR8r8crgy5cIED+iZYBQOZsw5yVqg
 1mphg05EwQh60pwtsBDFAasAn7n85hDgTQ9RCjH/tDbbov88nCJdc4gmq2zL/rWdDOunswnrJ
 E5YARY6Ncfz2YzgyVDlKLZttr4qNvTkaLOHfA+dmd9rtQHQraC0cS2Y3i6vDvQe3buTg0Bpve
 izuKV+aCOG29Q3UpCdVypxGOUPhxQfYaFXlB/FHq57u/EJNfRsu0HXO4GW5Qo0ihrURQ1PV8U
 dNxfztnkXME2ySgV8LxTxeTEw09FX5tJbH8uFlfNL4RQQ/m1AqXIc4MqrmE+gMzK1OAUwOF0e
 Ume6mUZxFWgssogyhuSJEbNdiivTBmFXHyHHN+h5Qgo97YMaW377SWap4eU7Nr9QXG7D2hz/N
 8ldV52O+CE94BbQIeqVFSIhPtzCTNOBwaDqqicOhw28Ndfg9d0hKlBY79PfmFNISk8fPh7w8K
 PhW+6KoXXdIp3i5YSNFlDXamIUu+JDS6LBiALsL72fte1k3jz8ttyXYU/WfCyfRRcbuyJTWtz
 QLl+3pAShdw2KdN64+nsm5DtOwgvPIFA8fpbnZRxNPNk2hqzot/JAed509mOQb5KTrYQf7Sn2
 ryv+aphcMjwpK/9hu8uvTi8WRCEl8HOI9UUfnNRB6Z5KOJdD4oIcG5QEUS4gIIsBtYcbzOAAK
 f537bOdz+NmNhrd8wlir3jIKphPLtAeawePpmDExemcSEmy4PsioFbb+N442o1vnJz8JKFef2
 by9Ovw6KBfnnlhaoadpUAfEiT3w=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------vYYRrMr75mZWgPjdmqDRCG6e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/3/8 22:28, Christoph Hellwig wrote:
> On Wed, Mar 08, 2023 at 02:04:26PM +0800, Qu Wenruo wrote:
>> BTW, I also checked if I can craft a scrub specific version of
>> btrfs_submit_bio().
>>
>> The result doesn't look good at all.
>>
>> Without a btrfs_bio structure, it's already pretty hard to properly put
>> bioc, decrease the bio counter.
>>
>> Or I need to create a scrub_bio, and re-implement all the needed endio
>> function handling.
>>
>> So please really consider the simplest case, one just wants to read/write
>> some data using logical + mirror_num, without any btrfs inode nor csum
>> verification.
> 
> As said before with a little more work we could get away without the
> inode.  But the above sounds a little strange to me.  Can you share
> your current code?  Maybe I can come up with some better ideas.

My current one is a new btrfs_submit_scrub_read() helper, getting rid of 
features I don't need and slightly modify the endio functions to avoid 
any checks if no bbio->inode. AKA, most of your idea.

So that would be mostly fine.


But what I'm exploring is to completely get rid of btrfs_ino, using 
plain bio.

Things like bio counter is not a big deal as the only caller is 
scrub/dev-replace, thus there would be no race to change dev-replace 
half-way.
So is bioc for non-RAID56 profiles, as we only need to grab the 
dev/physical and can release it immediately.

But for RAID56, the bioc has to live long enough for raid56 work to 
finish, thus has to go btrfs_raid56_end_io() and rely on the extra 
bbio->end_io().

I guess I have to accept the defeat and just go btrfs_bio.

Thanks,
Qu
--------------vYYRrMr75mZWgPjdmqDRCG6e
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-btrfs-introduce-a-new-helper-to-submit-bio-for-scrub.patch"
Content-Disposition: attachment;
 filename*0="0002-btrfs-introduce-a-new-helper-to-submit-bio-for-scrub.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4NWFiYzFkOGIwZDQ2M2Y5ZGI2ZDc0YTU4MDliMTA0ODdhZTIxZGU4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlkOiA8ODVhYmMxZDhiMGQ0NjNmOWRiNmQ3NGE1
ODA5YjEwNDg3YWUyMWRlOC4xNjc4MjYxMzc3LmdpdC53cXVAc3VzZS5jb20+CkluLVJlcGx5
LVRvOiA8Y292ZXIuMTY3ODI2MTM3Ny5naXQud3F1QHN1c2UuY29tPgpSZWZlcmVuY2VzOiA8
Y292ZXIuMTY3ODI2MTM3Ny5naXQud3F1QHN1c2UuY29tPgpGcm9tOiBRdSBXZW5ydW8gPHdx
dUBzdXNlLmNvbT4KRGF0ZTogV2VkLCA4IE1hciAyMDIzIDE0OjIyOjEwICswODAwClN1Ympl
Y3Q6IFtQQVRDSCAwMi8xMF0gYnRyZnM6IGludHJvZHVjZSBhIG5ldyBoZWxwZXIgdG8gc3Vi
bWl0IGJpbyBmb3Igc2NydWIKClRoZSBuZXcgaGVscGVyLCBidHJmc19zdWJtaXRfc2NydWJf
cmVhZCgpLCB3b3VsZCBiZSBtb3N0bHkgYSBzdWJzZXQgb2YKYnRyZnNfc3VibWl0X2Jpbygp
LCB3aXRoIHRoZSBmb2xsb3dpbmcgbGltaXRhdGlvbnM6CgotIE9ubHkgc3VwcG9ydHMgcmVh
ZAotIEBtaXJyb3JfbnVtIG11c3QgYmUgPiAwCi0gTm8gcmVhZC10aW1lIHJlcGFpciBub3Ig
Y2hlY2tzdW0gdmVyaWZpY2F0aW9uCi0gVGhlIEBiYmlvIG11c3Qgbm90IGNyb3NzIHN0cmlw
ZSBib3VuZGFyeQoKVGhpcyB3b3VsZCBwcm92aWRlIHRoZSBiYXNpcyBmb3IgdW5pZmllZCBy
ZWFkIHJlcGFpciBmb3Igc2NydWIsIGFzIHdlIG5vCmxvbmdlciBuZWVkcyB0byBoYW5kbGUg
UkFJRDU2IHJlY292ZXJ5IGFsbCBieSBzY3J1YiwgYW5kIFJBSUQ1NiBkYXRhCnN0cmlwZXMg
c2NydWIgY2FuIHNoYXJlIHRoZSBzYW1lIGNvZGUgb2YgcmVhZCBhbmQgcmVwYWlyLgoKVGhl
IHJlcGFpciBwYXJ0IHdvdWxkIGJlIHRoZSBzYW1lIGFzIG5vbi1SQUlENTYsIGFzIHdlIG9u
bHkgbmVlZCB0byB0cnkKdGhlIG5leHQgbWlycm9yLgoKU2lnbmVkLW9mZi1ieTogUXUgV2Vu
cnVvIDx3cXVAc3VzZS5jb20+Ci0tLQogZnMvYnRyZnMvYmlvLmMgfCA0MyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiBmcy9idHJmcy9iaW8uaCB8ICAy
ICsrCiAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvYmlvLmMgYi9mcy9idHJmcy9iaW8uYwppbmRleCA3
MjY1OTI4NjhlOWMuLjk2NjUxN2FkODFjZSAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvYmlvLmMK
KysrIGIvZnMvYnRyZnMvYmlvLmMKQEAgLTMwNSw4ICszMDUsOCBAQCBzdGF0aWMgdm9pZCBi
dHJmc19lbmRfYmlvX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQogewogCXN0cnVj
dCBidHJmc19iaW8gKmJiaW8gPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGJ0cmZzX2Jp
bywgZW5kX2lvX3dvcmspOwogCi0JLyogTWV0YWRhdGEgcmVhZHMgYXJlIGNoZWNrZWQgYW5k
IHJlcGFpcmVkIGJ5IHRoZSBzdWJtaXR0ZXIuICovCi0JaWYgKGJiaW8tPmJpby5iaV9vcGYg
JiBSRVFfTUVUQSkKKwkvKiBNZXRhZGF0YSBvciBzY3J1YiByZWFkcyBhcmUgY2hlY2tlZCBh
bmQgcmVwYWlyZWQgYnkgdGhlIHN1Ym1pdHRlci4gKi8KKwlpZiAoYmJpby0+YmlvLmJpX29w
ZiAmIFJFUV9NRVRBIHx8ICFiYmlvLT5pbm9kZSkKIAkJYmJpby0+ZW5kX2lvKGJiaW8pOwog
CWVsc2UKIAkJYnRyZnNfY2hlY2tfcmVhZF9iaW8oYmJpbywgYmJpby0+YmlvLmJpX3ByaXZh
dGUpOwpAQCAtMzQwLDcgKzM0MCw4IEBAIHN0YXRpYyB2b2lkIGJ0cmZzX3JhaWQ1Nl9lbmRf
aW8oc3RydWN0IGJpbyAqYmlvKQogCiAJYnRyZnNfYmlvX2NvdW50ZXJfZGVjKGJpb2MtPmZz
X2luZm8pOwogCWJiaW8tPm1pcnJvcl9udW0gPSBiaW9jLT5taXJyb3JfbnVtOwotCWlmIChi
aW9fb3AoYmlvKSA9PSBSRVFfT1BfUkVBRCAmJiAhKGJiaW8tPmJpby5iaV9vcGYgJiBSRVFf
TUVUQSkpCisJaWYgKGJpb19vcChiaW8pID09IFJFUV9PUF9SRUFEICYmIGJiaW8tPmlub2Rl
ICYmCisJICAgICEoYmJpby0+YmlvLmJpX29wZiAmIFJFUV9NRVRBKSkKIAkJYnRyZnNfY2hl
Y2tfcmVhZF9iaW8oYmJpbywgTlVMTCk7CiAJZWxzZQogCQlidHJmc19vcmlnX2JiaW9fZW5k
X2lvKGJiaW8pOwpAQCAtNjg2LDYgKzY4Nyw0MiBAQCBzdGF0aWMgYm9vbCBidHJmc19zdWJt
aXRfY2h1bmsoc3RydWN0IGJpbyAqYmlvLCBpbnQgbWlycm9yX251bSkKIAlyZXR1cm4gdHJ1
ZTsKIH0KIAorLyoKKyAqIFNjcnViIHJlYWQgc3BlY2lhbCB2ZXJzaW9uLCB3aXRoIGV4dHJh
IGxpbWl0czoKKyAqCisgKiAtIE9ubHkgc3VwcG9ydCByZWFkIGZvciBzY3J1YiB1c2FnZQor
ICogLSBAbWlycm9yX251bSBtdXN0IGJlID4wCisgKiAtIE5vIHJlYWQtdGltZSByZXBhaXIg
bm9yIGNoZWNrc3VtIHZlcmlmaWNhdGlvbi4KKyAqIC0gVGhlIEBiYmlvIG11c3Qgbm90IGNy
b3NzIHN0cmlwZSBib3VuZGFyeS4KKyAqLwordm9pZCBidHJmc19zdWJtaXRfc2NydWJfcmVh
ZChzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywKKwkJCSAgICAgc3RydWN0IGJ0cmZz
X2JpbyAqYmJpbywgaW50IG1pcnJvcl9udW0pCit7CisJc3RydWN0IGJ0cmZzX2JpbyAqb3Jp
Z19iYmlvID0gYmJpbzsKKwl1NjQgbG9naWNhbCA9IGJiaW8tPmJpby5iaV9pdGVyLmJpX3Nl
Y3RvciA8PCBTRUNUT1JfU0hJRlQ7CisJdTY0IGxlbmd0aCA9IGJiaW8tPmJpby5iaV9pdGVy
LmJpX3NpemU7CisJdTY0IG1hcF9sZW5ndGggPSBsZW5ndGg7CisJc3RydWN0IGJ0cmZzX2lv
X2NvbnRleHQgKmJpb2MgPSBOVUxMOworCXN0cnVjdCBidHJmc19pb19zdHJpcGUgc21hcDsK
KwlpbnQgcmV0OworCisJQVNTRVJUKG1pcnJvcl9udW0gPiAwKTsKKwlBU1NFUlQoYnRyZnNf
b3AoJmJiaW8tPmJpbykgPT0gQlRSRlNfTUFQX1JFQUQpOworCWJ0cmZzX2Jpb19jb3VudGVy
X2luY19ibG9ja2VkKGZzX2luZm8pOworCXJldCA9IF9fYnRyZnNfbWFwX2Jsb2NrKGZzX2lu
Zm8sIGJ0cmZzX29wKCZiYmlvLT5iaW8pLCBsb2dpY2FsLAorCQkJCSZtYXBfbGVuZ3RoLCAm
YmlvYywgJnNtYXAsICZtaXJyb3JfbnVtLCAxKTsKKwlpZiAocmV0KQorCQlnb3RvIGZhaWw7
CisKKwlBU1NFUlQobWFwX2xlbmd0aCA9PSBsZW5ndGgpOworCV9fYnRyZnNfc3VibWl0X2Jp
bygmYmJpby0+YmlvLCBiaW9jLCAmc21hcCwgbWlycm9yX251bSk7CisJcmV0dXJuOworCitm
YWlsOgorCWJ0cmZzX2Jpb19jb3VudGVyX2RlYyhmc19pbmZvKTsKKwlidHJmc19iaW9fZW5k
X2lvKG9yaWdfYmJpbywgcmV0KTsKK30KKwogdm9pZCBidHJmc19zdWJtaXRfYmlvKHN0cnVj
dCBiaW8gKmJpbywgaW50IG1pcnJvcl9udW0pCiB7CiAJd2hpbGUgKCFidHJmc19zdWJtaXRf
Y2h1bmsoYmlvLCBtaXJyb3JfbnVtKSkKZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Jpby5oIGIv
ZnMvYnRyZnMvYmlvLmgKaW5kZXggODczZmY4NTgxN2YwLi4zNDFkNTc5YmQwYjkgMTAwNjQ0
Ci0tLSBhL2ZzL2J0cmZzL2Jpby5oCisrKyBiL2ZzL2J0cmZzL2Jpby5oCkBAIC04OSw2ICs4
OSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBidHJmc19iaW9fZW5kX2lvKHN0cnVjdCBidHJm
c19iaW8gKmJiaW8sIGJsa19zdGF0dXNfdCBzdGF0dXMpCiAjZGVmaW5lIFJFUV9CVFJGU19P
TkVfT1JERVJFRAkJCVJFUV9EUlYKIAogdm9pZCBidHJmc19zdWJtaXRfYmlvKHN0cnVjdCBi
aW8gKmJpbywgaW50IG1pcnJvcl9udW0pOwordm9pZCBidHJmc19zdWJtaXRfc2NydWJfcmVh
ZChzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywKKwkJCSAgICAgc3RydWN0IGJ0cmZz
X2JpbyAqYmJpbywgaW50IG1pcnJvcl9udW0pOwogaW50IGJ0cmZzX3JlcGFpcl9pb19mYWls
dXJlKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCB1NjQgaW5vLCB1NjQgc3RhcnQs
CiAJCQkgICAgdTY0IGxlbmd0aCwgdTY0IGxvZ2ljYWwsIHN0cnVjdCBwYWdlICpwYWdlLAog
CQkJICAgIHVuc2lnbmVkIGludCBwZ19vZmZzZXQsIGludCBtaXJyb3JfbnVtKTsKLS0gCjIu
MzkuMQoK

--------------vYYRrMr75mZWgPjdmqDRCG6e--
