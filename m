Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D96E179C18
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 23:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbgCDW6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 17:58:42 -0500
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:50423 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387931AbgCDW6l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:58:41 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B2C97442C;
        Wed,  4 Mar 2020 22:58:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:871:960:973:982:988:989:1000:1260:1313:1314:1345:1359:1437:1516:1518:1535:1540:1575:1594:1711:1730:1747:1764:1777:1792:2393:2553:2559:2562:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3870:3871:3872:3873:3874:4118:4250:4321:5007:6506:6747:6748:7281:7514:7903:7974:10004:10394:10400:10848:10967:11232:11604:11658:11914:12297:12740:12895:13161:13229:13439:13618:14180:14181:14659:14721:21080:21325:21433:21451:21627:21740:21741:21789:21819:30022:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: trick98_688caee61ad1c
X-Filterd-Recvd-Size: 7192
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed,  4 Mar 2020 22:58:38 +0000 (UTC)
Message-ID: <e43f0cf0117fbfa8fe8c7e62538fd47a24b4657a.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Mar 2020 14:57:04 -0800
In-Reply-To: <alpine.DEB.2.21.2003042145340.2698@felia>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
         <20200304131035.731a3947@lwn.net>
         <alpine.DEB.2.21.2003042145340.2698@felia>
Content-Type: multipart/mixed; boundary="=-o23BfZrrZ2cR0WULJF0x"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--=-o23BfZrrZ2cR0WULJF0x
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Wed, 2020-03-04 at 21:50 +0100, Lukas Bulwahn wrote:
> 
> On Wed, 4 Mar 2020, Jonathan Corbet wrote:
> 
> > On Wed,  4 Mar 2020 08:29:50 +0100
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > Jonathan, pick pick this patch for doc-next.
> > 
> > Sigh, I need to work a MAINTAINERS check into my workflow...
> > 
> 
> I getting closer to have zero warnings on the MAINTAINER file matches and 
> then, I would set up a bot following the mailing lists to warn when anyone
> sends a patch that potentially introduces such warning.

Hey Lukas.

I wrote a hacky script that sent emails
for invalid MAINTAINER F: and X: patterns
a couple years back.

I ran it in September 2018 and March 2019.

It's attached if you want to play with it.
The email sending bit is commented out.

The script is used like:

$ perl ./scripts/get_maintainer.pl --self-test=patterns | \
  cut -f2 -d: | \
  while read line ; do \
    perl ./dump_section.perl $line \
  done


--=-o23BfZrrZ2cR0WULJF0x
Content-Type: application/x-perl; name="dump_section.perl"
Content-Disposition: attachment; filename="dump_section.perl"
Content-Transfer-Encoding: base64

bXkgJGkgPSAkQVJHVlswXTsKCm15IEBvdXRwdXQgPSAoKTsKbXkgQGxpbmVzID0gKCk7Cm9wZW4g
KG15ICRtYWludCwgJzwnLCAiTUFJTlRBSU5FUlMiKQogICAgb3IgZGllICIkUDogQ2FuJ3Qgb3Bl
biBNQUlOVEFJTkVSUyBmaWxlICdNQUlOVEFJTkVSUyc6ICQhXG4iOwp3aGlsZSAoPCRtYWludD4p
IHsKICAgIG15ICRsaW5lID0gJF87CiAgICBwdXNoKEBsaW5lcywgJGxpbmUpOwp9CmNsb3NlKCRt
YWludCk7CgpteSAkbG93X2luZGV4ID0gJGkgLSAxOwoKd2hpbGUgKCRsaW5lc1skbG93X2luZGV4
XSA9fiAvXi46LyAmJiAkbG93X2luZGV4ID4gMCkgewogICAgJGxvd19pbmRleC0tOwp9CgpteSAk
aGlnaF9pbmRleCA9ICRpIC0gMTsKd2hpbGUgKCRsaW5lc1skaGlnaF9pbmRleF0gPX4gL14uOi8g
JiYgJGhpZ2hfaW5kZXggPCAkI2xpbmVzKSB7CiAgICAkaGlnaF9pbmRleCsrOwp9CgpwdXNoKEBv
dXRwdXQsICJBIGZpbGUgcGF0dGVybiBsaW5lIGluIHRoaXMgc2VjdGlvbiBvZiB0aGUgTUFJTlRB
SU5FUlMgZmlsZSBpbiBsaW51eC1uZXh0XG4iKTsKcHVzaChAb3V0cHV0LCAiZG9lcyBub3QgaGF2
ZSBhIG1hdGNoIGluIHRoZSBsaW51eCBzb3VyY2UgZmlsZXMuXG4iKTsKcHVzaChAb3V0cHV0LCAi
XG4iKTsKcHVzaChAb3V0cHV0LCAiVGhpcyBjb3VsZCBvY2N1ciBiZWNhdXNlIGEgbWF0Y2hpbmcg
ZmlsZW5hbWUgd2FzIG5ldmVyIGFkZGVkLCB3YXMgZGVsZXRlZFxuIik7CnB1c2goQG91dHB1dCwg
Im9yIHJlbmFtZWQgaW4gc29tZSBvdGhlciBjb21taXQuXG4iKTsKcHVzaChAb3V0cHV0LCAiXG4i
KTsKcHVzaChAb3V0cHV0LCAiVGhlIGNvbW1pdHMgdGhhdCBhZGRlZCBhbmQgaWYgZm91bmQgcmVu
YW1lZCBvciByZW1vdmVkIHRoZSBmaWxlIHBhdHRlcm5cbiIpOwpwdXNoKEBvdXRwdXQsICJhcmUg
c2hvd24gYmVsb3cuXG4iKTsKcHVzaChAb3V0cHV0LCAiXG4iKTsKcHVzaChAb3V0cHV0LCAiUGxl
YXNlIGZpeCB0aGlzIGRlZmVjdCBhcHByb3ByaWF0ZWx5LlxuIik7CnB1c2goQG91dHB1dCwgIlxu
Iik7CgpwdXNoKEBvdXRwdXQsICIxOiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1cbiIpOwpwdXNoKEBvdXRw
dXQsICJcbiIpOwpwdXNoKEBvdXRwdXQsICJsaW51eC1uZXh0IE1BSU5UQUlORVJTIHNlY3Rpb246
XG4iKTsKcHVzaChAb3V0cHV0LCAiXG4iKTsKCm15ICRmaWxlID0gJGxpbmVzWyRpLTFdOwokZmls
ZSA9fiBzL15bQS1aXTpccysvLzsKY2hvbXAgJGZpbGU7CgpteSAkc2VjdGlvbiA9ICRsaW5lc1sk
bG93X2luZGV4XTsKCndoaWxlICgkbG93X2luZGV4IDwgJGhpZ2hfaW5kZXgpIHsKICAgIHB1c2go
QG91dHB1dCwgIi0tPiIpIGlmICgkbG93X2luZGV4ID09ICRpLTEpOwogICAgcHVzaChAb3V0cHV0
LCAiXHQiIC4gKCRsb3dfaW5kZXgrMSkgLiAiXHQiIC4gJGxpbmVzWyRsb3dfaW5kZXhdKTsKICAg
ICRsb3dfaW5kZXgrKzsKfQoKcHVzaChAb3V0cHV0LCAiXG4iKTsKcHVzaChAb3V0cHV0LCAiMjog
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tXG4iKTsKcHVzaChAb3V0cHV0LCAiXG4iKTsKCm15IEBibGFtZSA9
IGBnaXQgYmxhbWUgLUwkaSwrMSBNQUlOVEFJTkVSU2A7Cm15IEBjb21taXRzID0gc3BsaXQoJyAn
LCAkYmxhbWVbMF0pOwpteSAkY29tbWl0ID0gJGNvbW1pdHNbMF07Cm15IEBjb21taXRfbGluZXMg
PSBgZ2l0IGxvZyAtMSAtLXN0YXQgJGNvbW1pdGA7CgpwdXNoKEBvdXRwdXQsICJUaGUgbW9zdCBy
ZWNlbnQgY29tbWl0IHRoYXQgYWRkZWQgb3IgbW9kaWZpZWQgZmlsZSBwYXR0ZXJuICckZmlsZSc6
XG4iKTsKcHVzaChAb3V0cHV0LCAiXG4iKTsKcHVzaChAb3V0cHV0LCBAY29tbWl0X2xpbmVzKTsK
CnB1c2goQG91dHB1dCwgIlxuIik7CnB1c2goQG91dHB1dCwgIjM6IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LVxuIik7CnB1c2goQG91dHB1dCwgIlxuIik7CgpteSBAZm9sbG93ID0gYGdpdCBsb2cgLS1mb2xs
b3cgLTEgLS1zdGF0IC1NIC0tICckZmlsZSdgOwppZiAoIUBmb2xsb3cpIHsKICAgIHB1c2goQG91
dHB1dCwgIk5vIGNvbW1pdCB3aXRoIGZpbGUgcGF0dGVybiAnJGZpbGUnIHdhcyBmb3VuZFxuIik7
Cn0gZWxzZSB7CiAgICBteSAkY29tbWl0ID0gJGZvbGxvd1swXTsKICAgICRjb21taXQgPX4gcy9e
Y29tbWl0IC8vOwogICAgQGZvbGxvdyA9IGBnaXQgbG9nIC0tc3RhdCAtMSAtTSAkY29tbWl0YDsK
ICAgIHB1c2goQG91dHB1dCwgIlRoZSBsYXN0IGNvbW1pdCB3aXRoIGEgcmVhbCBwcmVzZW5jZSBv
ZiBmaWxlIHBhdHRlcm4gJyRmaWxlJzpcbiIpOwogICAgcHVzaChAb3V0cHV0LCAiXG4iKTsKICAg
IHB1c2goQG91dHB1dCwgQGZvbGxvdyk7Cn0KCm15IEBtYWludGFpbmVycyA9IGdyZXAoL15ccytc
ZCtccytbTFJNXTouKiQvLCBAb3V0cHV0KTsKbXkgQHNpZ25lcnMgPSBncmVwKC9eXHMrLiotYnk6
LiokLywgQG91dHB1dCk7CgpvcGVuIChteSAkZmlsZWgsICc+JywgInBhdHRlcm5zLyRpLnR4dCIp
OwoKJHNlY3Rpb24gPX4gcy9eXHMrXGQrXHMrLy87CiRzZWN0aW9uID1+IHMvXG4kLy87Cgpwcmlu
dCAkZmlsZWggIlN1YmplY3Q6IEJhZCBmaWxlIHBhdHRlcm4gaW4gTUFJTlRBSU5FUlMgc2VjdGlv
biAnJHNlY3Rpb24nXG4iOwpwcmludCAkZmlsZWggIlxuIjsKcHJpbnQgJGZpbGVoIChAb3V0cHV0
KTsKCmZvcmVhY2ggbXkgJG0gKEBtYWludGFpbmVycykgewogICAgJG0gPX4gcy9eXHMrXGQrXHMr
LjpccysvLzsKICAgICRtID1+IHMvXHMqXCguKlwpLiokLy87Cn0KCmZvcmVhY2ggbXkgJHMgKEBz
aWduZXJzKSB7CiAgICAkcyA9fiBzL15ccypbXHdcLV0rLWJ5OlxzKi8vOwp9CgojcHJpbnQgJGZp
bGVoICgiXG5tYWludGFpbmVyczpcblxuIik7CiNwcmludCAkZmlsZWggKEBtYWludGFpbmVycyk7
CiNwcmludCAkZmlsZWggKCJcbnNpZ25lcnM6XG5cbiIpOwojcHJpbnQgJGZpbGVoIChAc2lnbmVy
cyk7CgpteSBAZW1haWxzID0gKCk7CmZvcmVhY2ggbXkgJGVtYWlsIChAbWFpbnRhaW5lcnMsQHNp
Z25lcnMpIHsKICAgIHB1c2goQGVtYWlscywgJGVtYWlsKSB1bmxlc3MgJGF7JGVtYWlsfSsrOwp9
CgojcHJpbnQgJGZpbGVoICgiXG5lbWFpbHM6XG5cbiIpOwojcHJpbnQgJGZpbGVoIChAZW1haWxz
KTsKCm15ICRjYyA9ICIiOwpmb3JlYWNoIG15ICRlbWFpbCAoQGVtYWlscykgewogICAgbXkgJHQg
PSAkZW1haWw7CiAgICAkdCA9fiBzL1xuJC8vOwogICAgJHQgPX4gcy8iLy9nOwogICAgJGNjIC49
ICIgLS1jYyBcIiR0XCIiOwp9CgpjbG9zZSAkZmlsZWg7CgpteSAkZ3NtID0gImdpdCBzZW5kLWVt
YWlsIC0tdG8gXCJsaW51eC1rZXJuZWxcQHZnZXIua2VybmVsLm9yZ1wiIiAuICRjYyAuICIgcGF0
dGVybnMvJGkudHh0IjsKcHJpbnQoIiRnc21cbiIpOwoKI215IEBnc21fb3V0cHV0ID0gYCRnc21g
OwoKI3ByaW50KEBnc21fb3V0cHV0KTsK


--=-o23BfZrrZ2cR0WULJF0x--

